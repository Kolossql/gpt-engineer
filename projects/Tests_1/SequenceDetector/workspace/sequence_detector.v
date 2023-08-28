module sequence_detector (
  input wire clock,
  input wire reset,
  input wire [2:0] data,
  output wire sequence_found
);

  // State register
  reg [2:0] state;

  // Next state logic
  always @(posedge clock or negedge reset) begin
    if (!reset) begin
      state <= 3'b000; // Initial state
    end else begin
      case (state)
        3'b000: begin // Waiting for first element
          if (data == 3'b001) begin
            state <= 3'b001; // Transition to next state
          end
        end
        3'b001: begin // Checking for second element
          if (data == 3'b101) begin
            state <= 3'b010; // Transition to next state
          end else begin
            state <= 3'b000; // Reset to initial state
          end
        end
        3'b010: begin // Checking for third element
          if (data == 3'b110) begin
            state <= 3'b011; // Transition to next state
          end else begin
            state <= 3'b000; // Reset to initial state
          end
        end
        3'b011: begin // Checking for fourth element
          if (data == 3'b000) begin
            state <= 3'b100; // Transition to next state
          end else begin
            state <= 3'b000; // Reset to initial state
          end
        end
        3'b100: begin // Checking for fifth element
          if (data == 3'b110) begin
            state <= 3'b101; // Transition to next state
          end else begin
            state <= 3'b000; // Reset to initial state
          end
        end
        3'b101: begin // Checking for sixth element
          if (data == 3'b110) begin
            state <= 3'b110; // Transition to next state
          end else begin
            state <= 3'b000; // Reset to initial state
          end
        end
        3'b110: begin // Checking for seventh element
          if (data == 3'b011) begin
            state <= 3'b111; // Transition to next state
          end else begin
            state <= 3'b000; // Reset to initial state
          end
        end
        3'b111: begin // Checking for eighth element
          if (data == 3'b101) begin
            state <= 3'b000; // Transition to initial state
          end else begin
            state <= 3'b000; // Reset to initial state
          end
        end
      endcase
    end
  end

  // Output logic
  assign sequence_found = (state == 3'b111);

endmodule
