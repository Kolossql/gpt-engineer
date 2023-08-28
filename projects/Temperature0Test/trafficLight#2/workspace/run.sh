# Assuming you are using a package manager like apt or yum
# Replace <package-manager> with the appropriate package manager for your system
<package-manager> install verilator

# Compile the Verilog code
verilator -Wall --cc testbench.v --exe --build verilator_tb.cpp

# Run the simulation
./obj_dir/Vtestbench
