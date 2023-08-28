module SequenceDetector (
  input wire clk,
  input wire rst_n,
  input wire [2:0] data,
  output wire seq_found
);

  // Internal state variables
  reg [2:0] state;
  reg seq_found_reg;

  // Constants for sequence detection
  localparam [2:0] WAIT_FIRST = 3'b000;
  localparam [2:0] WAIT_SECOND = 3'b001;
  localparam [2:0] WAIT_THIRD = 3'b010;
  localparam [2:0] WAIT_FOURTH = 3'b011;
  localparam [2:0] WAIT_FIFTH = 3'b100;
  localparam [2:0] WAIT_SIXTH = 3'b101;
  localparam [2:0] WAIT_SEVENTH = 3'b110;
  localparam [2:0] WAIT_EIGHTH = 3'b111;

  // Sequential logic for sequence detection
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= WAIT_FIRST;
      seq_found_reg <= 1'b0;
    end else begin
      case (state)
        WAIT_FIRST:
          if (data == 3'b001)
            state <= WAIT_SECOND;
        WAIT_SECOND:
          if (data == 3'b101)
            state <= WAIT_THIRD;
          else
            state <= WAIT_FIRST;
        WAIT_THIRD:
          if (data == 3'b110)
            state <= WAIT_FOURTH;
          else
            state <= WAIT_FIRST;
        WAIT_FOURTH:
          if (data == 3'b000)
            state <= WAIT_FIFTH;
          else
            state <= WAIT_FIRST;
        WAIT_FIFTH:
          if (data == 3'b110)
            state <= WAIT_SIXTH;
          else
            state <= WAIT_FIRST;
        WAIT_SIXTH:
          if (data == 3'b110)
            state <= WAIT_SEVENTH;
          else
            state <= WAIT_FIRST;
        WAIT_SEVENTH:
          if (data == 3'b011)
            state <= WAIT_EIGHTH;
          else
            state <= WAIT_FIRST;
        WAIT_EIGHTH:
          if (data == 3'b101) begin
            state <= WAIT_FIRST;
            seq_found_reg <= 1'b1;
          end else
            state <= WAIT_FIRST;
      endcase
    end
  end

  // Assign output
  assign seq_found = seq_found_reg;

endmodule
