The necessary blocks for the testbench are:

1. Initialization block: This block will initialize the inputs and outputs of the DiceRoller module and set the initial state of the system.
2. Test case blocks: These blocks will each test a specific behavior of the DiceRoller module by setting the inputs to specific values and checking the output.

The important edge cases to test are:

1. The behavior of the system when the die select input is changed while the roll input is high.
2. The behavior of the system when the active-low reset is triggered during a roll.
3. The behavior of the system when the roll input goes high multiple times within a single clock cycle.
4. The behavior of the system when the roll input goes high and then low before the next clock rising edge.
5. The behavior of the system when the roll input stays high for multiple clock cycles.
6. The behavior of the system when the clock rising edge occurs while the roll input is transitioning from high to low or vice versa.
7. The behavior of the system when the die select input changes while the roll input is high and the clock is rising.

dice_roller_testbench.v
