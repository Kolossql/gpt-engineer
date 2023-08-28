module TrafficLightModule(
    input wire clk,
    input wire reset_n,
    input wire enable,
    output wire red,
    output wire yellow,
    output wire green
);

    // Instantiate TrafficLightController
    TrafficLightController controller(
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .state(state),
        .timer(timer)
    );

    // Instantiate StateMachine
    StateMachine state_machine(
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .red(red),
        .yellow(yellow),
        .green(green),
        .state(state),
        .timer(timer)
    );

    // Internal signals
    wire [4:0] timer;
    wire [1:0] state;

endmodule
