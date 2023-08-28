module traffic_light (
  input wire clk,
  input wire reset,
  input wire enable,
  output wire red,
  output wire yellow,
  output wire green
);

  // State definition
  localparam RED = 2'b00 ;
  localparam YELLOW = 2'b01 ;
  localparam GREEN = 2'b10 ;

  // State register
  reg [1:0] current_state;

  // Counter
  reg [5:0] counter;

  // Output logic
  assign red = (current_state == RED) ? 1'b1 : 1'b0;
  assign yellow = (current_state == YELLOW) ? 1'b1 : 1'b0;
  assign green = (current_state == GREEN) ? 1'b1 : 1'b0;

  // State machine logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= RED;
      counter <= 6'b0;
    end else if (enable) begin
      case (current_state)
        RED: begin
          if (counter == 6'b11111) begin
            current_state <= GREEN;
            counter <= 6'b0;
          end else begin
            counter <= counter + 1;
          end
        end
        GREEN: begin
          if (counter == 6'b10011) begin
            current_state <= YELLOW;
            counter <= 6'b0;
          end else begin
            counter <= counter + 1;
          end
        end
        YELLOW: begin
          if (counter == 6'b00111) begin
            current_state <= RED;
            counter <= 6'b0;
          end else begin
            counter <= counter + 1;
          end
        end
      endcase
    end
  end

endmodule
