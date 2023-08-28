module sequence_detector (
  input wire clk,
  input wire rst_n,
  input wire [2:0] data,
  output wire seq_found
);

  // State definition
  localparam WAIT_FIRST = 4b'0000;
  localparam WAIT_SECOND = 4b'0001;
  localparam WAIT_THIRD = 4b'0010;
  localparam WAIT_FOURTH = 4b'0011;
  localparam WAIT_FIFTH = 4b'0100;
  localparam WAIT_SIXTH = 4b'0101;
  localparam WAIT_SEVENTH = 4b'0110;
  localparam WAIT_EIGHTH = 4b'0111;
  localparam SEQUENCE_FOUND  = 4b'1000;

  // Internal signals
  reg [2:0] current_state;
  reg [2:0] next_state;

  // Output signal
  wire seq_found;

  // Sequential logic
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      current_state <= WAIT_FIRST;
    end else begin
      current_state <= next_state;
    end
  end

  // Combinational logic
  always @(*) begin
    next_state = current_state;
    seq_found = 0;

    case (current_state)
      WAIT_FIRST:
        if (data == 3'b001) begin
          next_state = WAIT_SECOND;
        end
      WAIT_SECOND:
        if (data == 3'b101) begin
          next_state = WAIT_THIRD;
        end
      WAIT_THIRD:
        if (data == 3'b110) begin
          next_state = WAIT_FOURTH;
        end
      WAIT_FOURTH:
        if (data == 3'b000) begin
          next_state = WAIT_FIFTH;
        end
      WAIT_FIFTH:
        if (data == 3'b110) begin
          next_state = WAIT_SIXTH;
        end
      WAIT_SIXTH:
        if (data == 3'b110) begin
          next_state = WAIT_SEVENTH;
        end
      WAIT_SEVENTH:
        if (data == 3'b011) begin
          next_state = WAIT_EIGHTH;
        end
      WAIT_EIGHTH:
        if (data == 3'b101) begin
          next_state = SEQUENCE_FOUND;
        end
      SEQUENCE_FOUND:
        seq_found = 1;
    endcase
  end

endmodule
