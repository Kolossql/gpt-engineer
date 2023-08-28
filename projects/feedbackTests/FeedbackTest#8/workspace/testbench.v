module ClockDriver(
    output reg clk
);
    always #5 clk = ~clk;
endmodule

module ResetDriver(
    output reg reset
);
    initial begin
        reset = 1;
        #10 reset = 0;
        #100 reset = 1;
        #10 reset = 0;
        #100 reset = 1;
    end
endmodule

module StimulusGenerator(
    input wire reset,
    output reg [2:0] data
);
    reg [2:0] sequence [7:0] = {3'b001, 3'b101, 3'b110, 3'b000, 3'b110, 3'b110, 3'b011, 3'b101};
    reg [2:0] index = 0;
    
    always @(posedge reset) begin
        index <= 0;
    end
    
    always @(posedge reset or posedge data) begin
        if (!reset) begin
            index <= index + 1;
            if (index >= 8) begin
                index <= 0;
            end
        end
    end
    
    always @(posedge reset or posedge index) begin
        if (!reset) begin
            data <= sequence[index];
        end
    end
endmodule

module Monitor(
    input wire sequence_found
);
    always @(posedge sequence_found) begin
        if (sequence_found) begin
            $display("Passed");
        end else begin
            $display("Failed");
        end
    end
endmodule

module Testbench;
    reg clk;
    reg reset;
    wire [2:0] data;
    wire sequence_found;
    
    ClockDriver clock_driver (
        .clk(clk)
    );
    
    ResetDriver reset_driver (
        .reset(reset)
    );
    
    StimulusGenerator stimulus_generator (
        .reset(reset),
        .data(data)
    );
    
    SequenceDetector dut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .sequence_found(sequence_found)
    );
    
    Monitor monitor (
        .sequence_found(sequence_found)
    );
    
    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, Testbench);
        
        #100;
        
        // Test 1: Input data matches the specified sequence
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #10 data = 3'b001;
        #10 data = 3'b101;
        #10 data = 3'b110;
        #10 data = 3'b000;
        #10 data = 3'b110;
        #10 data = 3'b110;
        #10 data = 3'b011;
        #10 data = 3'b101;
        
        // Test 2: Input data does not match the specified sequence
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #10 data = 3'b001;
        #10 data = 3'b101;
        #10 data = 3'b111;
        #10 data = 3'b000;
        #10 data = 3'b110;
        #10 data = 3'b110;
        #10 data = 3'b011;
        #10 data = 3'b101;
        
        // Test 3: Active-low reset signal is asserted
        #10 reset = 1;
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #10 data = 3'b001;
        #10 data = 3'b101;
        #10 data = 3'b110;
        #10 data = 3'b000;
        #10 data = 3'b110;
        #10 data = 3'b110;
        #10 data = 3'b011;
        #10 data = 3'b101;
        
        // Test 4: Input data changes while not actively detecting the sequence
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #10 data = 3'b001;
        #10 data = 3'b101;
        #10 data = 3'b110;
        #10 data = 3'b000;
        #10 data = 3'b111;
        #10 data = 3'b110;
        #10 data = 3'b011;
        #10 data = 3'b101;
        
        // Test 5: Continuous detection of the sequence after detecting the last element
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #10 data = 3'b001;
        #10 data = 3'b101;
        #10 data = 3'b110;
        #10 data = 3'b000;
        #10 data = 3'b110;
        #10 data = 3'b110;
        #10 data = 3'b011;
        #10 data = 3'b101;
        #10 data = 3'b001;
        #10 data = 3'b101;
        #10 data = 3'b110;
        #10 data = 3'b000;
        #10 data = 3'b110;
        #10 data = 3'b110;
        #10 data = 3'b011;
        #10 data = 3'b101;
        
        $finish;
    end
endmodule
