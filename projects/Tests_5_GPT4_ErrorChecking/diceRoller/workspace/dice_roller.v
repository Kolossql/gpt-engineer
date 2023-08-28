module DiceRoller(
    input wire clk,
    input wire reset_n,
    input wire [1:0] die_select,
    input wire roll,
    output reg [7:0] rolled_number
);

    // Random number generator
    reg [7:0] random_number;
    always @(posedge clk) begin
        random_number <= random_number + 1;
    end

    // Die selector
    reg [7:0] max_number;
    always @(die_select) begin
        case (die_select)
            2'b00: max_number <= 4;
            2'b01: max_number <= 6;
            2'b10: max_number <= 8;
            2'b11: max_number <= 20;
            default: max_number <= 4;
        endcase
    end

    // Roll control
    reg roll_flag;
    always @(posedge clk) begin
        if (roll && !roll_flag) begin
            roll_flag <= 1;
            rolled_number <= random_number % max_number + 1;
        end else if (!roll) begin
            roll_flag <= 0;
        end
    end

    // Reset control
    always @(negedge reset_n) begin
        roll_flag <= 0;
        rolled_number <= 0;
        random_number <= 0;
        max_number <= 4;
    end

endmodule
