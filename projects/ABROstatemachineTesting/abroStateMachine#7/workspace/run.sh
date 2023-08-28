# Assuming you have a package manager like apt or brew
# Install the Verilog simulator (e.g., Icarus Verilog)
apt install iverilog

iverilog -o testbench.vvp testbench.v ABRO.v

vvp testbench.vvp
