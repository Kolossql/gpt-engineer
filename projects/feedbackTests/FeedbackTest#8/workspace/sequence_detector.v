module SequenceDetector (
  input wire clk,
  input wire reset,
  input wire [2:0] data,
  output wire sequence_found
);

  // Define the states of the state machine
  typedef enum logic [2:0] {
    WAITING,
    STATE_1,
    STATE_2,
    STATE_3,
    STATE_4,
    STATE_5,
    STATE_6,
    STATE_7
  } state_t;

  // Define the signals for the state machine
  reg state_t current_state;
  reg state_t next_state;

  // Sequential logic for the state machine
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= WAITING;
    end else begin
      current_state <= next_state;
    end
  end

  // Combinational logic for the state transitions and outputs
  always @* begin
    next_state = current_state;
    sequence_found = 0;

    case (current_state)
      WAITING:
        if (data == 3'b001) begin
          next_state = STATE_1;
        end
      STATE_1:
        if (data == 3'b101) begin
          next_state = STATE_2;
        end
      STATE_2:
        if (data == 3'b110) begin
          next_state = STATE_3;
        end
      STATE_3:
        if (data == 3'b000) begin
          next_state = STATE_4;
        end
      STATE_4:
        if (data == 3'b110) begin
          next_state = STATE_5;
        end
      STATE_5:
        if (data == 3'b110) begin
          next_state = STATE_6;
        end
      STATE_6:
        if (data == 3'b011) begin
          next_state = STATE_7;
        end
      STATE_7:
        if (data == 3'b101) begin
          next_state = WAITING;
          sequence_found = 1;
        end
      default:
        next_state = WAITING;
    endcase
  end

endmodule
