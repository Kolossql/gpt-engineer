sudo apt-get install iverilog

iverilog -o testbench testbench.v abro_state_machine.v

vvp testbench
