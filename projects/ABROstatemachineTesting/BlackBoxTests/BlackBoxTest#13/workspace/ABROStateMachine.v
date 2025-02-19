module ABROStateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output reg [1:0] state
);

  // Internal signals
  reg [1:0] next_state;

  // State machine states
  localparam IDLE = 2'b00;
  localparam A_HIGH = 2'b01;
  localparam B_HIGH = 2'b10;
  localparam OUTPUT_SENT = 2'b11;

  // State machine logic
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      state <= IDLE;
    end else begin
      case (state)
        IDLE: begin
          if (A && B) begin
            next_state <= A_HIGH;
          end else begin
            next_state <= IDLE;
          end
        end
        A_HIGH: begin
          if (B) begin
            next_state <= B_HIGH;
          end else begin
            next_state <= A_HIGH;
          end
        end
        B_HIGH: begin
          if (A) begin
            next_state <= OUTPUT_SENT;
          end else begin
            next_state <= B_HIGH;
          end
        end
        OUTPUT_SENT: begin
          next_state <= IDLE;
        end
      endcase
    end
  end

  // Output logic
  always @(state) begin
    O = (state == OUTPUT_SENT) ? 1'b1 : 1'b0;
  end

  // State output
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

endmodule
