# Assuming you are using a package manager like apt or brew
# Install the necessary Verilog simulator (e.g., Icarus Verilog)
# Replace <package-manager> with the appropriate package manager command
<package-manager> install verilog

# Compile the testbench module and the sequence generator module
iverilog -o testbench sequence_generator_tb.v sequence_generator.v

# Run the compiled testbench
vvp testbench
