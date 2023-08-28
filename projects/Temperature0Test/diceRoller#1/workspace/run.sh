# Assuming you are using a package manager like apt-get or yum
# Replace <package-name> with the actual package name
<package-manager> install <package-name>

# Compile the Verilog files
iverilog -o testbench.vvp testbench.v dice_roller.v

# Run the simulation
vvp testbench.vvp
