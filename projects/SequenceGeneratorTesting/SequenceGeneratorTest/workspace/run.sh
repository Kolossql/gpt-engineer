# Install Verilator
sudo apt-get install verilator

# Install GTKWave
sudo apt-get install gtkwave

# Change to the codebase directory
cd codebase

# Compile the Verilog code using Verilator
verilator -Wall --cc sequence_generator.v --exe testbench.cpp

# Build the compiled Verilog code
make -C obj_dir -j -f Vsequence_generator.mk Vsequence_generator

# Run the testbench using the compiled Verilog code
./obj_dir/Vsequence_generator

# Open the waveform file in GTKWave
gtkwave waveform.vcd
