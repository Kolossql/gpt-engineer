brew install verilator

verilator -Wall --cc shift_register_tb.v --exe --build verilator_tb.cpp

./obj_dir/Vshift_register_tb
