sudo apt-get install iverilog

iverilog -o testbench testbench.v sequence_generator.v

vvp testbench

gtkwave WaveOutput.vcd
