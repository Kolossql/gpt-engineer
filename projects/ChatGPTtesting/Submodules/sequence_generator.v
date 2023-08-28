module sequence_generator(
    input clk,
    input rst_n,
    input enable,
    output [7:0] data
);
    wire [2:0] state;
    wire [2:0] count;
    wire [7:0] sequence_data;
    wire gated_clk;
    wire active_reset;
    wire active_enable;

    // Submodules
    state_machine_controller state_machine_inst(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .state(state)
    );

    counter counter_inst(
        .clk(clk),
        .rst_n(active_reset),
        .enable(active_enable),
        .count(count)
    );

    sequence_rom sequence_rom_inst(
        .addr(count),
        .data(sequence_data)
    );

    clock_gating clock_gating_inst(
        .clk(clk),
        .enable(enable),
        .gated_clk(gated_clk)
    );

    reset_logic reset_logic_inst(
        .rst_n(rst_n),
        .enable(enable),
        .active_reset(active_reset)
    );

    enable_logic enable_logic_inst(
        .enable(enable),
        .state(state),
        .active_enable(active_enable)
    );

    output_register output_register_inst(
        .clk(gated_clk),
        .data_in(sequence_data),
        .data_out(data)
    );
endmodule