sudo apt-get install -y iverilog

sudo apt-get install -y gtkwave

iverilog -o testbench.vvp testbench.v ABRO_state_machine.v

vvp testbench.vvp

gtkwave WaveOutput.vcd
