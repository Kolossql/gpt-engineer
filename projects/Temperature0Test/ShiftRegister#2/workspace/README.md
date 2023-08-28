The necessary blocks for testing the shift register module are as follows:

1. Testbench module: This module will instantiate the shift register module and provide the necessary inputs for testing. It will also monitor the outputs and verify their correctness.

Important edge cases to test in the testbench:

1. Initial state: Verify that the shift register starts with the correct initial state of 00000000.
2. Shift enable low: Verify that the shift register holds the current data without shifting when the shift enable signal is low.
3. Shift enable high: Verify that the shift register shifts the data bit on the rising edge of the clock when the shift enable signal is high.
4. Active-low reset: Verify that the shift register resets to the initial state when the active-low reset signal is asserted.
5. Data change: Verify that the shift register outputs the stored data when it is changed.

Now, let's proceed with the code implementation.

**shift_register_tb.v**

