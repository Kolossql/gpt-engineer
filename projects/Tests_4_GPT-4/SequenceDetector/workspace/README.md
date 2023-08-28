The necessary blocks for the testbench are:

- Initialization block: This block will initialize the inputs and outputs of the module under test (MUT). It will also instantiate the MUT.
- Test case blocks: These blocks will apply the test vectors to the MUT and check the outputs.

Important edge cases to test:

- The sequence is detected correctly.
- The sequence is not detected when it is not present.
- The sequence detection resets when the sequence is interrupted.
- The sequence detection continues when the sequence is detected more than once.
- The sequence detection does not occur when the detector is not enabled.

The testbench module:

testbench.v
