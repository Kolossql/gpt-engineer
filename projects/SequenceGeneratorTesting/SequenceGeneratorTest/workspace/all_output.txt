The necessary blocks for testing the sequence generator module are:
1. Testbench module: This module will instantiate the sequence generator module and provide the necessary inputs for testing.
2. Clock generator: This module will generate the clock signal for the testbench.
3. Reset generator: This module will generate the active-low reset signal for the testbench.
4. Enable generator: This module will generate the enable signal for the testbench.
5. Monitor: This module will monitor the output of the sequence generator module and check if it produces the expected sequence.

Important edge cases to test in the testbench:
1. Test the sequence generator with different clock frequencies.
2. Test the sequence generator with different reset timings.
3. Test the sequence generator with different enable timings.
4. Test the sequence generator with different initial states.
5. Test the sequence generator with different output delays.

Now let's proceed with the code implementation.