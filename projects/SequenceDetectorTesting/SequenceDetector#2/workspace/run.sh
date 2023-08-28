sudo apt-get update
sudo apt-get install -y iverilog

iverilog -o testbench.vvp testbench.v
vvp testbench.vvp
