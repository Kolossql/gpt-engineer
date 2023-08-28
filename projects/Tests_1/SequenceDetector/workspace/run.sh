cd <modelsim_folder>
./install

vlog testbench.v
vlog sequence_detector.v

vsim testbench

run -all
