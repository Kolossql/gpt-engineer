module traffic_light_module (
  input wire clk,
  input wire reset,
  input wire enable,
  output wire red,
  output wire yellow,
  output wire green
);

  // State Machine
  reg [1:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00; // Initial state: Red light with 32 clock cycles remaining before green
    end else if (enable) begin
      case (state)
        2'b00: begin // Red state
          if (counter == 32) begin
            state <= 2'b01; // Transition to Green state after 32 clock cycles
          end
        end
        2'b01: begin // Green state
          if (counter == 20) begin
            state <= 2'b10; // Transition to Yellow state after 20 clock cycles
          end
        end
        2'b10: begin // Yellow state
          if (counter == 7) begin
            state <= 2'b00; // Transition to Red state after 7 clock cycles
          end
        end
      endcase
    end
  end

  // Counter
  reg [5:0] counter;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 6'b0; // Reset counter to 0
    end else if (enable) begin
      if (counter == 6'b111111) begin
        counter <= 6'b0; // Reset counter to 0 at the end of the cycle
      end else begin
        counter <= counter + 1; // Increment counter
      end
    end
  end

  // Output assignment
  assign red = (state == 2'b00) ? 1'b1 : 1'b0;
  assign yellow = (state == 2'b10) ? 1'b1 : 1'b0;
  assign green = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
