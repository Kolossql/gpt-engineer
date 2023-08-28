sudo apt-get install iverilog

iverilog -o testbench shift_register_tb.v shift_register.v

vvp testbench -lxt2

gtkwave testbench.vcd
