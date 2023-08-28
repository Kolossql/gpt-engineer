The necessary blocks for the testbench are:

- Initialization: This block will initialize the inputs and outputs of the module to be tested.
- Test Cases: This block will contain the different test cases to be run on the module. Each test case will set the inputs to a specific state and then check the output against the expected result.

The important edge cases to be tested are:

- When the Shift enable is low, no shifting operation should occur regardless of the state of the clock.
- When the clock is not on the rising edge, no operations should be performed regardless of the state of the Shift enable.
- When the Active-low reset is engaged, the module should reset to its initial state.
- When the Data bit is inputted, the stored data should change and the output process should be triggered.

The content of the testbench module is as follows:

testbench.v
