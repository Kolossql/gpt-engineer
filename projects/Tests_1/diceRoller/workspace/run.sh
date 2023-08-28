# Install Verilog simulator (assuming you have Homebrew installed)
brew install verilator

# Compile the Verilog files
verilator -Wall --cc testbench.v dice_roller.v --exe --build sim_main.cpp

# Run the simulation
./sim_main
