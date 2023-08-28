# Assuming you are using a package manager like apt-get
apt-get install verilator

# Compile the Verilog code
verilator -Wall --cc testbench.v --exe --build verilator_tb

# Run the testbench
./verilator_tb
