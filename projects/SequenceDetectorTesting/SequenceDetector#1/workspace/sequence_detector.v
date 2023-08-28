module SequenceDetector (
  input wire clk,
  input wire reset_n,
  input wire [2:0] data,
  output wire sequence_found
);

  // Internal state definition
  reg [2:0] state;

  // Output signal
  //wire sequence_found;

  // State definitions
  localparam IDLE = 3'b000;
  localparam S1 = 3'b001;
  localparam S2 = 3'b010;
  localparam S3 = 3'b011;
  localparam S4 = 3'b100;
  localparam S5 = 3'b101;
  localparam S6 = 3'b110;
  localparam S7 = 3'b111;

  // Sequential logic
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      state <= IDLE;
    end else begin
      case (state)
        IDLE: begin
          if (data == 3'b001) begin
            state <= S1;
          end
        end
        S1: begin
          if (data == 3'b101) begin
            state <= S2;
          end else begin
            state <= IDLE;
          end
        end
        S2: begin
          if (data == 3'b110) begin
            state <= S3;
          end else begin
            state <= IDLE;
          end
        end
        S3: begin
          if (data == 3'b000) begin
            state <= S4;
          end else begin
            state <= IDLE;
          end
        end
        S4: begin
          if (data == 3'b110) begin
            state <= S5;
          end else begin
            state <= IDLE;
          end
        end
        S5: begin
          if (data == 3'b110) begin
            state <= S6;
          end else begin
            state <= IDLE;
          end
        end
        S6: begin
          if (data == 3'b011) begin
            state <= S7;
          end else begin
            state <= IDLE;
          end
        end
        S7: begin
          if (data == 3'b101) begin
            state <= IDLE;
          end else begin
            state <= IDLE;
          end
        end
      endcase
    end
  end

  // Combinational logic
  assign sequence_found = (state == S7);

endmodule
