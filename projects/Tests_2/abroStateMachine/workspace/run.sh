# For Ubuntu
sudo apt-get install iverilog

# For macOS
brew install icarus-verilog

iverilog -o simulation testbench.v

vvp simulation
