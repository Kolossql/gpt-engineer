# Install Verilator
apt-get install -y verilator

# Compile the Verilog code
verilator -Wall --cc traffic_light_module.v --exe traffic_light_tb.cpp

# Build the simulation executable
make -C obj_dir/ -f Vtraffic_light_module.mk Vtraffic_light_module

# Run the simulation
obj_dir/Vtraffic_light_module
