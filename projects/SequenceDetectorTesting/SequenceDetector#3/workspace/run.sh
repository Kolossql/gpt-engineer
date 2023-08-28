# Install ModelSim
wget http://download.altera.com/akdlm/software/acdsinst/20.1std/711/ib_installers/ModelSimSetup-20.1.0.711-linux.run
chmod +x ModelSimSetup-20.1.0.711-linux.run
./ModelSimSetup-20.1.0.711-linux.run

# Install GTKWave
sudo apt-get install gtkwave

# Compile the Verilog files
vlog testbench.v sequence_detector.v

# Run the simulation
vsim -c testbench -do "run -all; quit"

# View the waveforms
gtkwave testbench.vcd
