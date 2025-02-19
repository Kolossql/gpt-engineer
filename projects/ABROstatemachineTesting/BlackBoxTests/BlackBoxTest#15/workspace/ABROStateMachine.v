module ABROStateMachine (
  input wire clk,
  input wire reset,
  input wire a,
  input wire b,
  output wire o,
  output reg [3:0] state
);

  // State definitions
  localparam IDLE = 4'b0000;
  localparam A_HIGH = 4'b0001;
  localparam B_HIGH = 4'b0010;
  localparam AB_HIGH = 4'b0011;

  // State register
  reg [3:0] next_state;

  // Output register
  reg o_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset the state machine to the initial state
      state <= IDLE;
      o_reg <= 1'b0;
    end else begin
      // State machine logic
      case (state)
        IDLE: begin
          if (a && b) begin
            next_state <= AB_HIGH;
            o_reg <= 1'b1;
          end else if (a) begin
            next_state <= A_HIGH;
          end else if (b) begin
            next_state <= B_HIGH;
          end
        end
        A_HIGH: begin
          if (b) begin
            next_state <= AB_HIGH;
            o_reg <= 1'b1;
          end
        end
        B_HIGH: begin
          if (a) begin
            next_state <= AB_HIGH;
            o_reg <= 1'b1;
          end
        end
        AB_HIGH: begin
          if (!(a && b)) begin
            next_state <= IDLE;
            o_reg <= 1'b0;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    // Update the state register
    state <= next_state;
  end

  // Assign the output
  assign o = o_reg;

endmodule
