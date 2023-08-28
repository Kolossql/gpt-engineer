sudo apt-get install iverilog

iverilog -o testbench.vvp testbench.v dice_roller.v

vvp testbench.vvp
