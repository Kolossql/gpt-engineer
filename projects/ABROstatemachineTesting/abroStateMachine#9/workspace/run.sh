sudo apt-get install iverilog

iverilog -o testbench.vvp testbench.v abro_state_machine.v

vvp testbench.vvp
