`timescale 1ns/1ps

module testbench;

reg [7:0] binary_input;
reg clk;
reg reset_n;
wire [11:0] BCD_output;

Binary_to_BCD U1 (
    .binary_input(binary_input),
    .clk(clk),
    .reset_n(reset_n),
    .BCD_output(BCD_output)
);

initial 
begin
    $dumpfile("Binary_to_BCD.vcd");
    $dumpvars(0, testbench);
    clk = 0;
    forever #5 clk = ~clk; 
end

initial
begin
    reset_n = 0;
    binary_input = 0;
    #10;
    reset_n = 1;
    #10;
    binary_input = 8'h12; // BCD value should be 18
    #10;
    binary_input = 8'hFF; // BCD value should be 255
    #10;
    binary_input = 8'hA3; // BCD value should be 163
    #20;
    $finish;
end

initial 
begin
    #30;
    if(BCD_output == 12'h18)
        $display("Test passed for input 8'h12, BCD value is: %h", BCD_output);
    else
        $display("Test failed for input 8'h12, BCD value is: %h", BCD_output);
    
    #10;
    if(BCD_output == 12'h255)
        $display("Test passed for input 8'hFF, BCD value is: %h", BCD_output);
    else
        $display("Test failed for input 8'hFF, BCD value is: %h", BCD_output);

    #10;
    if(BCD_output == 12'h163)
        $display("Test passed for input 8'hA3, BCD value is: %h", BCD_output);
    else
        $display("Test failed for input 8'hA3, BCD value is: %h", BCD_output);
end

endmodule