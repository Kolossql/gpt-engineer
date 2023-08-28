sudo apt-get update
sudo apt-get install -y iverilog

sudo apt-get install -y gtkwave

iverilog -o testbench.vvp testbench.v

vvp testbench.vvp

gtkwave testbench.vcd
