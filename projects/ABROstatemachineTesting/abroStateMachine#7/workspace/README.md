The blocks necessary to properly test the ABRO module are:
1. Testbench module: This module will instantiate the ABRO module and provide stimulus to its inputs. It will also monitor the outputs and verify their correctness.
2. Clock generator: This block will generate a clock signal to drive the ABRO module.
3. Reset generator: This block will generate an active-low reset signal to reset the ABRO module.
4. Stimulus generator: This block will generate stimulus for the A and B inputs of the ABRO module.
5. Monitor: This block will monitor the outputs of the ABRO module and check if they are correct.

Important edge cases to test in the testbench:
1. Testing the initial state where A and B are not entered.
2. Testing the case where A is entered before B.
3. Testing the case where B is entered before A.
4. Testing the case where A and B are entered in the correct order.
5. Testing the case where A and B are entered in the incorrect order.

Now let's proceed with the testbench module:

**testbench.v**
