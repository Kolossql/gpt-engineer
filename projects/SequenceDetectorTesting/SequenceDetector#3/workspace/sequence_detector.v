module SequenceDetector (
  input wire clk,
  input wire reset_n,
  input wire [2:0] data,
  output wire sequence_found
);

  // Internal state variables
  reg [2:0] state;
  reg sequence_found;

  // State definitions
  localparam IDLE = 3'b000;
  localparam SEQ1 = 3'b001;
  localparam SEQ2 = 3'b010;
  localparam SEQ3 = 3'b011;
  localparam SEQ4 = 3'b100;
  localparam SEQ5 = 3'b101;
  localparam SEQ6 = 3'b110;
  localparam SEQ7 = 3'b111;

  // Sequential logic
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      state <= IDLE;
      sequence_found <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 3'b001)
            state <= SEQ1;
          else
            state <= IDLE;
        end
        SEQ1: begin
          if (data == 3'b101)
            state <= SEQ2;
          else
            state <= IDLE;
        end
        SEQ2: begin
          if (data == 3'b110)
            state <= SEQ3;
          else
            state <= IDLE;
        end
        SEQ3: begin
          if (data == 3'b000)
            state <= SEQ4;
          else
            state <= IDLE;
        end
        SEQ4: begin
          if (data == 3'b110)
            state <= SEQ5;
          else
            state <= IDLE;
        end
        SEQ5: begin
          if (data == 3'b110)
            state <= SEQ6;
          else
            state <= IDLE;
        end
        SEQ6: begin
          if (data == 3'b011)
            state <= SEQ7;
          else
            state <= IDLE;
        end
        SEQ7: begin
          if (data == 3'b101) begin
            state <= IDLE;
            sequence_found <= 1;
          end else begin
            state <= IDLE;
          end
        end
      endcase
    end
  end

endmodule
