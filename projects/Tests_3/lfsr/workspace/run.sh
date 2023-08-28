sudo apt-get install iverilog

iverilog -o testbench testbench.v

vvp testbench

gtkwave WaveOutput.vcd
