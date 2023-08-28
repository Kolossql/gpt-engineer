The necessary blocks for the testbench are:

1. Initialization block: This block will initialize the inputs and outputs of the ABROStateMachine module and set the initial conditions for the testbench.

2. Test case blocks: These blocks will each test a specific case or edge case. They will set the inputs to the ABROStateMachine module, run the module, and then check the outputs against the expected results.

The important edge cases to test are:

1. Both inputs A and B are 0.
2. Both inputs A and B are 1.
3. Input A is 1 and input B is 0.
4. Input A is 0 and input B is 1.
5. The active-low reset is triggered.

Now, let's write the testbench module.

testbench.v
