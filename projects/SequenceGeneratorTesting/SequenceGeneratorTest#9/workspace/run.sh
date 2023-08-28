brew install verilator

verilator -Wall --cc sequence_generator_tb.v --exe --build verilator_tb.cpp

./obj_dir/Vsequence_generator_tb
