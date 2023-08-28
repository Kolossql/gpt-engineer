sudo apt-get install verilator

sudo apt-get install iverilog

iverilog -o sequence_generator_tb sequence_generator_tb.v

vvp sequence_generator_tb
