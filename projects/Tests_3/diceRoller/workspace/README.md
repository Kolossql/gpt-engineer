The necessary blocks for testing the module are as follows:

1. Testbench module: This module will instantiate the module under test and provide stimulus to its inputs. It will also monitor the outputs and compare them with expected values to verify the correctness of the design.

Important edge cases to test in the testbench:

1. Test with a 4-sided die, roll input high, and clock rising edge.
2. Test with a 6-sided die, roll input high, and clock rising edge.
3. Test with an 8-sided die, roll input high, and clock rising edge.
4. Test with a 20-sided die, roll input high, and clock rising edge.
5. Test with roll input low and clock rising edge.

Now, let's proceed with the content of the testbench module:

testbench.v
