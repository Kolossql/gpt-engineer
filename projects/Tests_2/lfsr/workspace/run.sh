sudo apt-get install iverilog

sudo apt-get install gtkwave

iverilog -o testbench.vvp testbench.v

vvp testbench.vvp

gtkwave testbench.vcd
