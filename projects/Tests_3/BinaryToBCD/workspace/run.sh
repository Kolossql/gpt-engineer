sudo apt-get install iverilog

iverilog -o testbench testbench.v binary_to_bcd_converter.v

vvp testbench

gtkwave WaveOutput.vcd
