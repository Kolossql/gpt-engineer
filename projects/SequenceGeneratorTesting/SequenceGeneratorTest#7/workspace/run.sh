# Assuming you are using a package manager like apt-get
apt-get install verilator

# Compile the Verilog files
verilator -Wall --cc sequence_generator.v testbench.v --exe --build verilator_tb

# Run the simulation
./obj_dir/verilator_tb
