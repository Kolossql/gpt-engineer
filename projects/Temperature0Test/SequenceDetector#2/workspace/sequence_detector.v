module SequenceDetector (
  input wire clk,
  input wire rst_n,
  input wire [2:0] data,
  output reg sequence_found
);

  // State definition
  typedef enum logic [2:0] {
    WAITING,
    DETECTING_1,
    DETECTING_2,
    DETECTING_3,
    DETECTING_4,
    DETECTING_5,
    DETECTING_6,
    DETECTING_7,
    SEQUENCE_FOUND
  } State;

  // Internal signals
  reg [2:0] current_state;
  reg [2:0] next_state;

  // State transition and output logic
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      current_state <= WAITING;
      sequence_found <= 0;
    end else begin
      current_state <= next_state;
      sequence_found <= (next_state == SEQUENCE_FOUND);
    end
  end

  // State transition and output logic
  always @(current_state, data) begin
    next_state = current_state;
    case (current_state)
      WAITING:
        if (data == 3'b001)
          next_state = DETECTING_1;
      DETECTING_1:
        if (data == 3'b101)
          next_state = DETECTING_2;
      DETECTING_2:
        if (data == 3'b110)
          next_state = DETECTING_3;
      DETECTING_3:
        if (data == 3'b000)
          next_state = DETECTING_4;
      DETECTING_4:
        if (data == 3'b110)
          next_state = DETECTING_5;
      DETECTING_5:
        if (data == 3'b110)
          next_state = DETECTING_6;
      DETECTING_6:
        if (data == 3'b011)
          next_state = DETECTING_7;
      DETECTING_7:
        if (data == 3'b101)
          next_state = SEQUENCE_FOUND;
      default:
        next_state = WAITING;
    endcase
  end

endmodule
