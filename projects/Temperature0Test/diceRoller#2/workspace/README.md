The blocks necessary to properly test the module are:
1. Testbench module: This module will instantiate the module under test and provide stimulus to its inputs. It will also monitor the outputs and verify their correctness.
2. Clock generator: This block will generate the clock signal for the testbench module.
3. Reset generator: This block will generate the active-low reset signal for the testbench module.
4. Stimulus generator: This block will generate the stimulus for the inputs of the testbench module, including the die select and roll signals.
5. Monitor: This block will monitor the outputs of the testbench module and capture them for verification.

Important edge cases to test in the testbench:
1. Testing the initial state of the roll with a 4-sided die.
2. Testing the roll with a 6-sided die.
3. Testing the roll with an 8-sided die.
4. Testing the roll with a 20-sided die.
5. Testing the active-low reset functionality.

Now let's proceed with the content of the testbench module:

**testbench.v**
