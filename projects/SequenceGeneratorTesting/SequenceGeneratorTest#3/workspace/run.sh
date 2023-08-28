# Assuming you have a package manager like apt or brew
# Install the Verilog simulator (e.g., Icarus Verilog)
apt install iverilog

# Compile the Verilog files
iverilog -o sim sequence_generator_tb.v sequence_generator.v

# Run the simulation
vvp sim
