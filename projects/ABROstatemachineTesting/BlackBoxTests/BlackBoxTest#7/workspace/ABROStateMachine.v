module ABROStateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [2:0] state
);

  // State Register
  reg [2:0] current_state;
  always @(posedge clk or negedge reset) begin
    if (!reset)
      current_state <= 3'b000; // Initial state
    else
      current_state <= next_state;
  end

  // State Decoder
  reg [2:0] next_state;
  always @(current_state, A, B) begin
    case (current_state)
      3'b000: // State 0
        if (A && B)
          next_state = 3'b001; // Transition to State 1
        else
          next_state = current_state;
      3'b001: // State 1
        if (A && !B)
          next_state = 3'b010; // Transition to State 2
        else if (!A && B)
          next_state = 3'b100; // Transition to State 4
        else
          next_state = current_state;
      3'b010: // State 2
        if (!A && B)
          next_state = 3'b011; // Transition to State 3
        else if (A && !B)
          next_state = 3'b101; // Transition to State 5
        else
          next_state = current_state;
      3'b011: // State 3
        if (A && B)
          next_state = 3'b110; // Transition to State 6
        else
          next_state = current_state;
      3'b100: // State 4
        if (A && B)
          next_state = 3'b101; // Transition to State 5
        else
          next_state = current_state;
      3'b101: // State 5
        if (!A && B)
          next_state = 3'b110; // Transition to State 6
        else if (A && !B)
          next_state = 3'b010; // Transition to State 2
        else
          next_state = current_state;
      3'b110: // State 6
        if (A && B)
          next_state = 3'b111; // Transition to State 7
        else
          next_state = current_state;
      3'b111: // State 7
        if (!A && !B)
          next_state = 3'b000; // Transition to State 0
        else
          next_state = current_state;
      default:
        next_state = current_state;
    endcase
  end

  // Output Logic
  assign O = (current_state == 3'b111) ? 1'b1 : 1'b0;

  // Reset Logic
  always @(posedge clk or negedge reset) begin
    if (!reset)
      current_state <= 3'b000; // Initial state
  end

  // Output current state for verification
  assign state = current_state;

endmodule
