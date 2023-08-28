sudo apt-get install iverilog

iverilog -o lfsr_testbench lfsr_testbench.v

vvp lfsr_testbench
