import inspect
import re
import subprocess
import json

from enum import Enum
from typing import List, Union

from langchain.schema import AIMessage, HumanMessage, SystemMessage
from termcolor import colored

from gpt_engineer.ai import AI
from gpt_engineer.chat_to_files import to_files, find_file_names
from gpt_engineer.db import DBs
from gpt_engineer.learning import human_input

import subprocess, shlex

Message = Union[AIMessage, HumanMessage, SystemMessage]


def setup_sys_prompt(dbs: DBs) -> str:
    return (
        dbs.preprompts["generate"] + "\nUseful to know:\n" + dbs.preprompts["philosophy"]
    )


def get_prompt(dbs: DBs) -> str:
    """While we migrate we have this fallback getter"""
    assert (
        "prompt" in dbs.input or "main_prompt" in dbs.input
    ), "Please put your prompt in the file `prompt` in the project directory"

    if "prompt" not in dbs.input:
        print(
            colored("Please put the prompt in the file `prompt`, not `main_prompt", "red")
        )
        print()
        return dbs.input["main_prompt"]

    return dbs.input["prompt"]


def curr_fn() -> str:
    """Get the name of the current function"""
    return inspect.stack()[1].function


# All steps below have the signature Step


def simple_gen(ai: AI, dbs: DBs) -> List[Message]:
    """Run the AI on the main prompt and save the results"""
    messages = ai.start(setup_sys_prompt(dbs), get_prompt(dbs), step_name=curr_fn())
    to_files(messages[-1].content.strip(), dbs.workspace)
    return messages


def clarify(ai: AI, dbs: DBs) -> List[Message]:
    """
    Ask the user if they want to clarify anything and save the results to the workspace
    """
    messages: List[Message] = [ai.fsystem(dbs.preprompts["clarify"])]
    user_input = get_prompt(dbs)
    while True:
        messages = ai.next(messages, user_input, step_name=curr_fn())
        msg = messages[-1].content.strip()

        if msg == "Nothing more to clarify.":
            break

        if msg.lower().startswith("no"):
            print("Nothing more to clarify.")
            break

        print()
        user_input = input('(answer in text, or "c" to move on)\n')
        print()

        if not user_input or user_input == "c":
            print("(letting gpt-engineer make its own assumptions)")
            print()
            messages = ai.next(
                messages,
                "Make your own assumptions and state them explicitly before starting",
                step_name=curr_fn(),
            )
            print()
            return messages

        user_input += (
            "\n\n"
            "Is anything else unclear? If yes, only answer in the form:\n"
            "{remaining unclear areas} remaining questions.\n"
            "{Next question}\n"
            'If everything is sufficiently clear, only answer "Nothing more to clarify.".'
        )

    print()
    return messages


def gen_spec(ai: AI, dbs: DBs) -> List[Message]:
    """
    Generate a spec from the main prompt + clarifications and save the results to
    the workspace
    """
    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
        ai.fsystem(f"Instructions: {dbs.input['prompt']}"),
    ]

    messages = ai.next(messages, dbs.preprompts["spec"], step_name=curr_fn())

    dbs.memory["specification"] = messages[-1].content.strip()

    return messages


def respec(ai: AI, dbs: DBs) -> List[Message]:
    messages = AI.deserialize_messages(dbs.logs[gen_spec.__name__])
    messages += [ai.fsystem(dbs.preprompts["respec"])]

    messages = ai.next(messages, step_name=curr_fn())
    messages = ai.next(
        messages,
        (
            "Based on the conversation so far, please reiterate the specification for "
            "the program. "
            "If there are things that can be improved, please incorporate the "
            "improvements. "
            "If you are satisfied with the specification, just write out the "
            "specification word by word again."
        ),
        step_name=curr_fn(),
    )

    dbs.memory["specification"] = messages[-1].content.strip()
    return messages


def gen_unit_tests(ai: AI, dbs: DBs) -> List[dict]:
    """
    Generate unit tests based on the specification, that should work.
    """
    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
        ai.fuser(f"Instructions: {dbs.input['prompt']}"),
        ai.fuser(f"Specification:\n\n{dbs.memory['specification']}"),
    ]

    messages = ai.next(messages, dbs.preprompts["unit_tests"], step_name=curr_fn())

    dbs.memory["unit_tests"] = messages[-1].content.strip()
    to_files(dbs.memory["unit_tests"], dbs.workspace)

    return messages

def gen_clarified_code(ai: AI, dbs: DBs) -> List[dict]:
    """Takes clarification and generates code"""
    messages = AI.deserialize_messages(dbs.logs[clarify.__name__])

    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
    ] + messages[1:]
    messages = ai.next(messages, dbs.preprompts["use_qa"], step_name=curr_fn())

    to_files(messages[-1].content.strip(), dbs.workspace)
    return messages

def gen_caravel_user_wrapper(ai: AI, dbs: DBs) -> List[dict]:
    messages = AI.deserialize_messages(dbs.logs[gen_blackbox_clarified_code.__name__])

    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
    ] + messages[1:]
    messages = ai.next(messages, dbs.preprompts["caravel_wrapper"], step_name=curr_fn())

    to_files(messages[-1].content.strip(), dbs.workspace, "user_wrapper")

    return messages

def gen_verilog_testbench(ai: AI, dbs: DBs) -> List[dict]:
    """Takes clarification and generates a Verilog testbench"""
    messages = AI.deserialize_messages(dbs.logs[clarify.__name__])

    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
    ] + messages[1:]
    messages = ai.next(messages, dbs.preprompts["gen_testbench"], step_name=curr_fn())

    to_files(messages[-1].content.strip(), dbs.workspace)
    return messages

def gen_blackbox(ai: AI, dbs: DBs) -> List[dict]:
    """Takes clarification and generates a blackbox which contains the inputs and outputs
       and a brief description of the module to be written"""
    messages = AI.deserialize_messages(dbs.logs[clarify.__name__])

    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
    ] + messages[1:]
    messages = ai.next(messages, dbs.preprompts["blackbox"], step_name=curr_fn())

    to_files(messages[-1].content.strip(), dbs.workspace, "blackbox")
    return messages

def gen_blackbox_clarified_code(ai: AI, dbs: DBs) -> List[dict]:
    """Takes clarification and blackbox and generates code"""
    messages = AI.deserialize_messages(dbs.logs[gen_blackbox.__name__])

    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
    ] + messages[1:]
    messages = ai.next(messages, dbs.preprompts["use_qa_bl"], step_name=curr_fn())

    to_files(messages[-1].content.strip(), dbs.workspace, "blackboxCode")
    return messages

def gen_blackbox_verilog_testbench(ai: AI, dbs: DBs) -> List[dict]:
    """Takes clarification and blackbox and generates a verilog testbench"""
    messages = AI.deserialize_messages(dbs.logs[gen_blackbox.__name__])

    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
    ] + messages[1:]
    messages = ai.next(messages, dbs.preprompts["gen_testbench_bl"], step_name=curr_fn())

    to_files(messages[-1].content.strip(), dbs.workspace, "blackboxTestbench")
    return messages

def check_output_syntax(ai: AI, dbs: DBs) -> List[dict]:

    checkErrors = True
    loopNum = 0
    while checkErrors:

        ## Loads the blackbox and the generation of the module and testbench
        messages = AI.deserialize_messages(dbs.logs[gen_blackbox.__name__])
        module = AI.deserialize_messages(dbs.logs[gen_blackbox_clarified_code.__name__])
        testbench = AI.deserialize_messages(dbs.logs[gen_blackbox_verilog_testbench.__name__])

        ## Gets all filesnames from both the generation of the module and testbench
        files = find_file_names(module[-1].content) + find_file_names(testbench[-1].content)
        filenames = ""
        fileMessages = ""

        ## reads each file directly using the filenames retrieved above
        for i in files:
            filenames += i+" "
            file = open((str(dbs.workspace.path.joinpath(i))), "r")
            
            #Formats the code according to the following format
            ##FILENAME
            # ``` LANG
            # CODE
            # ```
            fileMessages += "\n"+i+"\n```verilog\n"+file.read()+"\n```"

        ## Runs the files in iverilog and records any syntax issues
        args = shlex.split("iverilog -o attempt#"+ str(loopNum)+ " "+filenames)
        #--- Diagnostic
        print('')
        print('Diagnostic:')
        print('Running iverilog with command line: ' + ' '.join(args))
        print('(Current working directory is: ' + str(dbs.workspace.path) + ')')
        #---
        process = subprocess.run(args, capture_output = True, cwd = str(dbs.workspace.path) )
        output = str(process.stdout).strip("b'").replace("\\n", "\n").replace("\\r", "") +"   "+ str(process.stderr).strip("b'").replace("\\n", "\n").replace("\\r", "")

        ## Checks to ensure that iverilog did finish running
        if str(output) == str(bytes()):
            output = "The module and testbench never finished running"

        ## Message chain attatches files and output after the clarification and blackbox messages
        files = ai.fassistant(fileMessages)
        output = ai.fassistant(output)
        messages = [
            ai.fsystem(setup_sys_prompt(dbs)),
        ] + messages[1:] + [files, output]

        ## To do:  Automatically break on no output (no syntax errors)
        
        ## Prints the outputs so that the user can decide to run the error checking again or not
        print("\n\n -----iverilog output------ \n\n" +output.content+"\n\n -----iverilog output------ \n\n")

        # runs the ai if and only if the user accepts it
        checkErrors = False
        if (input("Would you like to automatically debug based on this output? (y or n) ") == "y"):
            loopNum += 1
            messages = ai.next(messages, dbs.preprompts["Testing"], step_name=curr_fn())
            checkErrors = True
            
        

        to_files(messages[-1].content.strip(), dbs.workspace, "Testing#" + str(loopNum))
    return messages

def check_output_testbench(ai: AI, dbs: DBs) -> List[dict]:

    checkErrors = True
    loopNum = 0
    while checkErrors:

        ## Loads the blackbox and the generation of the module and testbench
        messages = AI.deserialize_messages(dbs.logs[gen_blackbox.__name__])
        module = AI.deserialize_messages(dbs.logs[gen_blackbox_clarified_code.__name__])
        testbench = AI.deserialize_messages(dbs.logs[gen_blackbox_verilog_testbench.__name__])

        ## Gets all filesnames from both the generation of the module and testbench
        files = find_file_names(module[-1].content) + find_file_names(testbench[-1].content)
        filenames = ""
        fileMessages = ""

        ## reads each file directly using the filenames retrieved above
        for i in files:
            filenames += i+" "
            file = open((str(dbs.workspace.path.joinpath(i))), "r")
            
            #Formats the code according to the following format
            ##FILENAME
            # ``` LANG
            # CODE
            # ```
            fileMessages += "\n"+i+"\n```verilog\n"+file.read()+"\n```"

        ## Re-run iverilog and capture output to make sure the updated
        ## testbench has been recompiled.  Ideally, this should not be done
        ## the first time, but need to know the loopNum from the previous
        ## step.
        args = shlex.split("iverilog -o attempt#"+ str(loopNum)+ " "+filenames)
        process = subprocess.run(args, capture_output = True, cwd = str(dbs.workspace.path) )
        output0 = str(process.stdout).strip("b'").replace("\\n", "\n").replace("\\r", "") +"   "+ str(process.stderr).strip("b'").replace("\\n", "\n").replace("\\r", "")

        ## Runs the compiled testbench in vvp and records both successful and unsuccesful outputs
        args = shlex.split("vvp attempt#"+ str(loopNum))
        #--- Diagnostic
        print('')
        print('Diagnostic:')
        print('Running vvp with command line: ' + ' '.join(args))
        print('(Current working directory is: ' + str(dbs.workspace.path) + ')')
        #---
        process = subprocess.run(args, capture_output = True, cwd = str(dbs.workspace.path) )
        output = str(process.stdout).strip("b'").replace("\\n", "\n").replace("\\r", "") +"   "+ str(process.stderr).strip("b'").replace("\\n", "\n").replace("\\r", "")

        ## Checks to ensure that vvp did finish running
        if str(output) == str(bytes()):
            output = "The module and testbench never finished running"

        ## Message chain attatches files and output after the clarification and blackbox messages
        files = ai.fassistant(fileMessages)
        output = ai.fassistant(output0 + output)
        messages = [
            ai.fsystem(setup_sys_prompt(dbs)),
        ] + messages[1:] + [files, output]
        
        ## Prints the outputs so that the user can decide to run the error checking again or not
        print("\n\n -----vvp output------ \n\n" +output.content+"\n\n -----vvp output------ \n\n")

        # runs the ai if and only if the user accepts it
        checkErrors = False
        if (input("Would you like to automatically debug based on this output? (y or n) ") == "y"):
            loopNum += 1
            messages = ai.next(messages, dbs.preprompts["Testing"], step_name=curr_fn())
            checkErrors = True

        to_files(messages[-1].content.strip(), dbs.workspace, "Testing#" + str(loopNum))
    return messages

def gen_code(ai: AI, dbs: DBs) -> List[dict]:
    # get the messages from previous step
    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
        ai.fuser(f"Instructions: {dbs.input['prompt']}"),
        ai.fuser(f"Specification:\n\n{dbs.memory['specification']}"),
        ai.fuser(f"Unit tests:\n\n{dbs.memory['unit_tests']}"),
    ]
    messages = ai.next(messages, dbs.preprompts["use_qa"], step_name=curr_fn())
    to_files(messages[-1].content.strip(), dbs.workspace)
    return messages

def execute_entrypoint(ai: AI, dbs: DBs) -> List[dict]:
    command = dbs.workspace["run.sh"]

    print("Do you want to execute this code?")
    print()
    print(command)
    print()
    print('If yes, press enter. Otherwise, type "no"')
    print()
    if input() not in ["", "y", "yes"]:
        print("Ok, not executing the code.")
        return []
    print("Executing the code...")
    print()
    print(
        colored(
            "Note: If it does not work as expected, consider running the code"
            + " in another way than above.",
            "green",
        )
    )
    print()
    print("You can press ctrl+c *once* to stop the execution.")
    print()

    p = subprocess.Popen("bash run.sh", shell=True, cwd=dbs.workspace.path)
    try:
        p.wait()
    except KeyboardInterrupt:
        print()
        print("Stopping execution.")
        print("Execution stopped.")
        p.kill()
        print()

    return []

def gen_entrypoint(ai: AI, dbs: DBs) -> List[dict]:
    messages = ai.start(
        system=(
            "You will get information about a codebase that is currently on disk in "
            "the current folder.\n"
            "From this you will answer with code blocks that includes all the necessary "
            "unix terminal commands to "
            "a) install dependencies "
            "b) run all necessary parts of the codebase (in parallel if necessary).\n"
            "Do not install globally. Do not use sudo.\n"
            "Do not explain the code, just give the commands.\n"
            "Do not use placeholders, use example values (like . for a folder argument) "
            "if necessary.\n"
        ),
        user="Information about the codebase:\n\n" + dbs.workspace["all_output.txt"],
        step_name=curr_fn(),
    )
    print()

    regex = r"```\S*\n(.+?)```"
    matches = re.finditer(regex, messages[-1].content.strip(), re.DOTALL)
    dbs.workspace["run.sh"] = "\n".join(match.group(1) for match in matches)
    return messages

def use_feedback(ai: AI, dbs: DBs):
    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
        ai.fuser(f"Instructions: {dbs.input['prompt']}"),
        ai.fassistant(dbs.workspace["all_output.txt"]),
        ai.fsystem(dbs.preprompts["use_feedback"]),
    ]
    messages = ai.next(messages, dbs.input["feedback"], step_name=curr_fn())
    to_files(messages[-1].content.strip(), dbs.workspace)
    return messages

def fix_code(ai: AI, dbs: DBs):
    messages = AI.deserialize_messages(dbs.logs[gen_code.__name__])
    code_output = messages[-1].content.strip()
    messages = [
        ai.fsystem(setup_sys_prompt(dbs)),
        ai.fuser(f"Instructions: {dbs.input['prompt']}"),
        ai.fuser(code_output),
        ai.fsystem(dbs.preprompts["fix_code"]),
    ]
    messages = ai.next(
        messages, "Please fix any errors in the code above.", step_name=curr_fn()
    )
    to_files(messages[-1].content.strip(), dbs.workspace)
    return messages

def human_review(ai: AI, dbs: DBs):
    review = human_input()
    dbs.memory["review"] = review.to_json()  # type: ignore
    return []


class Config(str, Enum):
    DEFAULT = "default"
    VERILOGDEFAULT = "verilogdefault"
    BLACKBOX = "blackbox"
    BLACKBOXPLUS = "blackbox+"
    BLACKBOXCARAVEL = "blackboxcaravel"
    BENCHMARK = "benchmark"
    SIMPLE = "simple"
    TDD = "tdd"
    TDD_PLUS = "tdd+"
    CLARIFY = "clarify"
    RESPEC = "respec"
    EXECUTE_ONLY = "execute_only"
    EVALUATE = "evaluate"
    USE_FEEDBACK = "use_feedback"


# Different configs of what steps to run
STEPS = {
    Config.DEFAULT: [
        clarify,
        gen_clarified_code,
        gen_entrypoint,
        execute_entrypoint,
        human_review,
    ],
    Config.VERILOGDEFAULT: [
        clarify,
        gen_clarified_code,
        gen_verilog_testbench,
        gen_entrypoint,
        execute_entrypoint,
        human_review,
    ],
    Config.BLACKBOX: [
        clarify,
        gen_blackbox,
        gen_blackbox_clarified_code,
        gen_blackbox_verilog_testbench,
        ],
    Config.BLACKBOXPLUS: [
        clarify,
        gen_blackbox,
        gen_blackbox_clarified_code,
        gen_blackbox_verilog_testbench,
        check_output_syntax,
        check_output_testbench,
        ],
    Config.BLACKBOXCARAVEL: [
        clarify,
        gen_blackbox,
        gen_blackbox_clarified_code,
        gen_blackbox_verilog_testbench,
        gen_caravel_user_wrapper,
        ],
    Config.BENCHMARK: [simple_gen, gen_entrypoint],
    Config.SIMPLE: [simple_gen, gen_entrypoint, execute_entrypoint],
    Config.TDD: [
        gen_spec,
        gen_unit_tests,
        gen_code,
        gen_entrypoint,
        execute_entrypoint,
        human_review,
    ],
    Config.TDD_PLUS: [
        gen_spec,
        gen_unit_tests,
        gen_code,
        fix_code,
        gen_entrypoint,
        execute_entrypoint,
        human_review,
    ],
    Config.CLARIFY: [
        clarify,
        gen_clarified_code,
        gen_entrypoint,
        execute_entrypoint,
        human_review,
    ],
    Config.RESPEC: [
        gen_spec,
        respec,
        gen_unit_tests,
        gen_code,
        fix_code,
        gen_entrypoint,
        execute_entrypoint,
        human_review,
    ],
    Config.USE_FEEDBACK: [use_feedback, gen_entrypoint, execute_entrypoint, human_review],
    Config.EXECUTE_ONLY: [execute_entrypoint],
    Config.EVALUATE: [execute_entrypoint, human_review],
}

# Future steps that can be added:
# run_tests_and_fix_files
# execute_entrypoint_and_fix_files_if_it_results_in_error
