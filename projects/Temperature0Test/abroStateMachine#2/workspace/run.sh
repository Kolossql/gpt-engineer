sudo apt-get install -y iverilog

iverilog -o abro_tb abro.v testbench.v

vvp abro_tb
