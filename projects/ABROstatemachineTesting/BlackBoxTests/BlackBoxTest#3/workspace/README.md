The necessary blocks for testing the ABROStateMachine module are:
1. Testbench module: This module will instantiate the ABROStateMachine module and provide stimulus to its inputs. It will also verify the correctness of the outputs.
2. Clock generator: This block will generate the clock signal for the testbench module.
3. Reset generator: This block will generate the active-low reset signal for the testbench module.
4. Stimulus generator: This block will generate the stimulus for the A and B inputs of the testbench module.
5. Output checker: This block will compare the expected output with the actual output of the testbench module and display the result.

Important edge cases to test in the testbench:
1. A and B are both low after reset: This tests if the module correctly waits for A and B to be high before sending the output.
2. A is high before B after reset: This tests if the module correctly waits for both A and B to be high in any order before sending the output.
3. B is high before A after reset: This tests if the module correctly waits for both A and B to be high in any order before sending the output.
4. A and B are both high after reset: This tests if the module correctly sends the output when both A and B have been high at least once.
5. A or B transitions from high to low after meeting the requirement: This tests if the module correctly ignores the transition from high to low after meeting the requirement.

ABROStateMachineTestbench
