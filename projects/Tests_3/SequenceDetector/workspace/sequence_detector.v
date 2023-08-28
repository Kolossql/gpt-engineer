module sequence_detector (
  input wire clk,
  input wire rst_n,
  input wire [2:0] data,
  output wire seq_found
);

  // Define the states of the sequence detector
  
   parameter [3:0] WAITING = 4'b0000;
   parameter [3:0] SEQ_1 = 4'b0001;
   parameter [3:0] SEQ_2 = 4'b0010;
   parameter [3:0] SEQ_3 = 4'b0011;
   parameter [3:0] SEQ_4 = 4'b0100;
   parameter [3:0] SEQ_5 = 4'b0101;
   parameter [3:0] SEQ_6 = 4'b0110;
   parameter [3:0] SEQ_7 = 4'b0111;
   parameter [3:0] SEQ_8 = 4'b1000;
   parameter [3:0] SEQ_FOUND = 4'b1001;
   

  // Define the sequence to be detected
  parameter [2:0] SEQ_1_VAL = 3'b001;
  parameter [2:0] SEQ_2_VAL = 3'b101;
  parameter [2:0] SEQ_3_VAL = 3'b110;
  parameter [2:0] SEQ_4_VAL = 3'b000;
  parameter [2:0] SEQ_5_VAL = 3'b110;
  parameter [2:0] SEQ_6_VAL = 3'b110;
  parameter [2:0] SEQ_7_VAL = 3'b011;
  parameter [2:0] SEQ_8_VAL = 3'b101;

  // Define the state and sequence registers
  reg [2:0] sequence;

  reg [3:0] state;
  // Output signal
  // wire seq_found;

  // Sequential logic
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= WAITING;
      sequence <= 0;
    end else begin
      case (state)
        WAITING: begin
          if (data == SEQ_1_VAL)
            state <= SEQ_1;
        end
        SEQ_1: begin
          if (data == SEQ_2_VAL)
            state <= SEQ_2;
          else
            state <= WAITING;
        end
        SEQ_2: begin
          if (data == SEQ_3_VAL)
            state <= SEQ_3;
          else
            state <= WAITING;
        end
        SEQ_3: begin
          if (data == SEQ_4_VAL)
            state <= SEQ_4;
          else
            state <= WAITING;
        end
        SEQ_4: begin
          if (data == SEQ_5_VAL)
            state <= SEQ_5;
          else
            state <= WAITING;
        end
        SEQ_5: begin
          if (data == SEQ_6_VAL)
            state <= SEQ_6;
          else
            state <= WAITING;
        end
        SEQ_6: begin
          if (data == SEQ_7_VAL)
            state <= SEQ_7;
          else
            state <= WAITING;
        end
        SEQ_7: begin
          if (data == SEQ_8_VAL)
            state <= SEQ_8;
          else
            state <= WAITING;
        end
        SEQ_8: begin
          if (data == SEQ_1_VAL)
            state <= SEQ_FOUND;
          else
            state <= WAITING;
        end
        SEQ_FOUND: begin
          state <= WAITING;
        end
      endcase
    end
  end

  // Combinational logic
  assign seq_found = (state == SEQ_FOUND) ? 1 : 0;

endmodule
