# Assuming you have a package manager like apt or brew
# Install the Verilog simulator (e.g., Icarus Verilog)
apt install iverilog

# Compile the Verilog files
iverilog -o testbench.vvp testbench.v sequence_detector.v

# Run the simulation
vvp testbench.vvp

# View the waveform using GTKWave (optional)
gtkwave WaveOutput.vcd
