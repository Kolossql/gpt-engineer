# For Ubuntu
sudo apt-get install iverilog

# For macOS
brew install icarus-verilog

iverilog -o testbench.vvp testbench.v

vvp testbench.vvp
