sudo apt-get install verilator

verilator -Wall --cc testbench.v --exe --build verilator_tb

./verilator_tb
