sudo apt-get install iverilog

# Compile the Verilog files
iverilog -o simulation testbench.v abro_state_machine.v

# Run the simulation
vvp simulation
