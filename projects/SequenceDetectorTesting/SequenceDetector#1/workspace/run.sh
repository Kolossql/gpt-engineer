# Install Icarus Verilog
sudo apt-get install -y iverilog

# Compile the Verilog code
iverilog -o sequence_detector_tb sequence_detector_tb.v

# Run the simulation
vvp sequence_detector_tb
