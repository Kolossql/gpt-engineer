module sequence_generator (
  input wire clk,
  input wire rst_n,
  input wire enable,
  output reg [7:0] data
);

  // Internal state variables
  reg [2:0] state;
  
  // Sequence values
  reg [7:0] SEQUENCE [0:7] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};
  
  // Output data assignment
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      data <= SEQUENCE[0];
      state <= 0;
    end else if (enable) begin
      case (state)
        0: begin
          data <= SEQUENCE[0];
          state <= 1;
        end
        1: begin
          data <= SEQUENCE[1];
          state <= 2;
        end
        2: begin
          data <= SEQUENCE[2];
          state <= 3;
        end
        3: begin
          data <= SEQUENCE[3];
          state <= 4;
        end
        4: begin
          data <= SEQUENCE[4];
          state <= 5;
        end
        5: begin
          data <= SEQUENCE[5];
          state <= 6;
        end
        6: begin
          data <= SEQUENCE[6];
          state <= 7;
        end
        7: begin
          data <= SEQUENCE[7];
          state <= 0;
        end
        default: begin
          data <= SEQUENCE[0];
          state <= 0;
        end
      endcase
    end
  end

endmodule
