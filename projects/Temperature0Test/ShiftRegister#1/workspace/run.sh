# Assuming you have a package manager like apt or brew
# Install the necessary Verilog simulator (e.g., Icarus Verilog)
apt install iverilog

# Compile the Verilog files
iverilog -o shift_register_tb shift_register_tb.v shift_register.v

# Run the simulation
vvp shift_register_tb
