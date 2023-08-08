module ABROStateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [n-1:0] State_Output
);
  // State definition
  parameter STATE_INITIAL = 2'b00;
  parameter STATE_A_HIGH = 2'b01;
  parameter STATE_B_HIGH = 2'b10;
  parameter STATE_AB_HIGH = 2'b11;
  
  // Internal state register
  reg [1:0] state;
  
  // Output register
  reg O_reg;
  
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      // Reset state and output
      state <= STATE_INITIAL;
      O_reg <= 1'b0;
    end else begin
      case (state)
        STATE_INITIAL:
          if (A && B) begin
            state <= STATE_AB_HIGH;
            O_reg <= 1'b1;
          end else if (A) begin
            state <= STATE_A_HIGH;
          end else if (B) begin
            state <= STATE_B_HIGH;
          end
        STATE_A_HIGH:
          if (B) begin
            state <= STATE_AB_HIGH;
            O_reg <= 1'b1;
          end
        STATE_B_HIGH:
          if (A) begin
            state <= STATE_AB_HIGH;
            O_reg <= 1'b1;
          end
        STATE_AB_HIGH:
          if (!(A && B)) begin
            state <= STATE_INITIAL;
            O_reg <= 1'b0;
          end
      endcase
    end
  end
  
  // Assign outputs
  assign O = O_reg;
  assign State_Output = state;
  
endmodule
