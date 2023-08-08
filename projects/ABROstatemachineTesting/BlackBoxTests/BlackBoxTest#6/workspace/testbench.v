module ClockGenerator(
    input wire clk_in,
    output reg clk_out
);
    always begin
        #5 clk_out = ~clk_out;
    end
endmodule

module StimulusGenerator(
    input wire clk,
    output reg reset,
    output reg A,
    output reg B
);
    reg [2:0] count;
    
    always @(posedge clk) begin
        count <= count + 1;
        
        case (count)
            3'd0: begin
                reset <= 1;
                A <= 0;
                B <= 0;
            end
            3'd1: begin
                reset <= 0;
                A <= 1;
                B <= 0;
            end
            3'd2: begin
                reset <= 0;
                A <= 0;
                B <= 1;
            end
            3'd3: begin
                reset <= 0;
                A <= 1;
                B <= 1;
            end
            default: begin
                reset <= 0;
                A <= 0;
                B <= 0;
            end
        endcase
    end
endmodule

module Monitor(
    input wire clk,
    input wire O,
    input wire [1:0] State
);
    always @(posedge clk) begin
        $display("Output O: %b", O);
        $display("Current State: %b", State);
    end
endmodule

module ABROStateMachine_tb;
    reg clk;
    wire O;
    wire [1:0] State;
    
    ClockGenerator clock_gen(
        .clk_in(clk),
        .clk_out(clk)
    );
    
    StimulusGenerator stimulus_gen(
        .clk(clk),
        .reset(),
        .A(),
        .B()
    );
    
    ABROStateMachine dut(
        .Clock(clk),
        .Reset(stimulus_gen.reset),
        .A(stimulus_gen.A),
        .B(stimulus_gen.B),
        .O(O),
        .State(State)
    );
    
    Monitor monitor(
        .clk(clk),
        .O(O),
        .State(State)
    );
    
    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, ABROStateMachine_tb);
        
        #10;
        
        // Test 1: Initial state
        $display("Test 1: Initial state");
        stimulus_gen.reset <= 1;
        #10;
        stimulus_gen.reset <= 0;
        #10;
        
        // Test 2: Single high input
        $display("Test 2: Single high input");
        stimulus_gen.A <= 1;
        #10;
        stimulus_gen.A <= 0;
        #10;
        
        // Test 3: Both inputs high in any order
        $display("Test 3: Both inputs high in any order");
        stimulus_gen.A <= 1;
        stimulus_gen.B <= 0;
        #10;
        stimulus_gen.A <= 0;
        stimulus_gen.B <= 1;
        #10;
        
        // Test 4: Both inputs high in order
        $display("Test 4: Both inputs high in order");
        stimulus_gen.A <= 1;
        stimulus_gen.B <= 0;
        #10;
        stimulus_gen.B <= 1;
        #10;
        
        // Test 5: Reset
        $display("Test 5: Reset");
        stimulus_gen.reset <= 1;
        #10;
        stimulus_gen.reset <= 0;
        #10;
        
        $finish;
    end
endmodule
