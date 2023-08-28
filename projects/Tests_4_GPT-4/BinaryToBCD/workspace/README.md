The necessary blocks for the testbench are:

1. Initialization block: This block will initialize the inputs and outputs of the module under test.
2. Test case block: This block will contain the test cases that will be used to verify the functionality of the module under test.

The important edge cases to test are:

1. Minimum input value (0)
2. Maximum input value (255)
3. A value in the middle of the range (128)
4. A value just above the middle of the range (129)
5. A value just below the middle of the range (127)

Now, let's write the testbench module:

testbench.v
