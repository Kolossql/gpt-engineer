module SequenceDetector (
  input wire clk,
  input wire reset,
  input wire [2:0] data,
  output wire sequence_found
);

  // Internal state variables
  reg [2:0] state;
  reg sequence_found_reg;

  // Constants for sequence detection
  localparam [2:0] WAITING = 3'b000;
  localparam [2:0] SEQ1 = 3'b001;
  localparam [2:0] SEQ2 = 3'b010;
  localparam [2:0] SEQ3 = 3'b011;
  localparam [2:0] SEQ4 = 3'b100;
  localparam [2:0] SEQ5 = 3'b101;
  localparam [2:0] SEQ6 = 3'b110;
  localparam [2:0] SEQ7 = 3'b111;

  // Sequential logic for sequence detection
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= WAITING;
      sequence_found_reg <= 1'b0;
    end else begin
      case (state)
        WAITING: begin
          if (data == 3'b001)
            state <= SEQ1;
        end
        SEQ1: begin
          if (data == 3'b101)
            state <= SEQ2;
          else
            state <= WAITING;
        end
        SEQ2: begin
          if (data == 3'b110)
            state <= SEQ3;
          else
            state <= WAITING;
        end
        SEQ3: begin
          if (data == 3'b000)
            state <= SEQ4;
          else
            state <= WAITING;
        end
        SEQ4: begin
          if (data == 3'b110)
            state <= SEQ5;
          else
            state <= WAITING;
        end
        SEQ5: begin
          if (data == 3'b110)
            state <= SEQ6;
          else
            state <= WAITING;
        end
        SEQ6: begin
          if (data == 3'b011)
            state <= SEQ7;
          else
            state <= WAITING;
        end
        SEQ7: begin
          if (data == 3'b101) begin
            state <= WAITING;
            sequence_found_reg <= 1'b1;
          end else
            state <= WAITING;
        end
      endcase
    end
  end

  // Combinational logic for output
  assign sequence_found = sequence_found_reg;

endmodule
