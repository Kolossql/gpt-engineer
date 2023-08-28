# Assuming you have a package manager like apt or brew
# Replace <package_manager> with the appropriate package manager for your system
<package_manager> install verilator gtkwave

# Compile the Verilog code
verilator -Wall --cc testbench.v --exe --build verilator_tb

# Run the simulation
./obj_dir/verilator_tb

# View the waveform in GTKWave
gtkwave WaveOutput.vcd
