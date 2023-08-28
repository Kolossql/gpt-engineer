# Install Verilator
apt-get install -y verilator

# Compile the Verilog code using Verilator
verilator -Wall --cc testbench.v --exe --build verilator_tb.cpp

# Run the simulation
./obj_dir/Vtestbench
