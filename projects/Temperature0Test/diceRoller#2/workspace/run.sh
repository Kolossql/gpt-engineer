# Assuming you are using a package manager like apt-get or brew
# Install the Verilog simulator (e.g., Icarus Verilog)
# Replace 'verilog-simulator' with the appropriate package name for your package manager
$ package_manager install verilog-simulator

# Assuming the testbench module is named 'testbench.v' and the module under test is named 'dice_roller.v'
$ iverilog -o testbench testbench.v dice_roller.v

$ vvp testbench
