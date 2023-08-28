# Assuming you have a package manager like apt or brew
# Install the Verilog simulator (e.g., Icarus Verilog)
apt install iverilog

# Compile the Verilog code
iverilog -o testbench.vvp testbench.v sequence_detector.v

# Run the compiled code
vvp testbench.vvp
