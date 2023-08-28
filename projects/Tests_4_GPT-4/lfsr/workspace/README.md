The necessary blocks for the testbench are:

1. Initialization block: This block is used to initialize the inputs and call the module under test.
2. Test case blocks: These blocks are used to define the different test cases that will be run on the module.

The important edge cases to test are:

1. When the clock signal is at the rising edge.
2. When the reset signal is active-low.
3. When the reset signal is not active-low.
4. When the module is in its initial state.
5. When the module has been running for some time.

Now, let's write the testbench code:

testbench.v
