sudo apt-get install -y iverilog

iverilog -o traffic_light_tb traffic_light_tb.v

vvp traffic_light_tb
