module DiceRoller(
    input wire clk,
    input wire reset_n,
    input wire [1:0] die_select,
    input wire roll,
    output reg [7:0] rolled_number
);

    // Random Number Generator
    reg [7:0] random_number;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            random_number <= 8'h0;
        else
            random_number <= random_number + 8'h1;
    end

    // Die Selector
    reg [7:0] die_max;
    always @(die_select) begin
        case (die_select)
            2'b00: die_max = 8'h4;  // 4-sided die
            2'b01: die_max = 8'h6;  // 6-sided die
            2'b10: die_max = 8'h8;  // 8-sided die
            2'b11: die_max = 8'h14; // 20-sided die
            default: die_max = 8'h4; // default to 4-sided die
        endcase
    end

    // Roll Controller
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            rolled_number <= 8'h0;
        else if (roll)
            rolled_number <= (random_number % die_max) + 1;
    end

endmodule
