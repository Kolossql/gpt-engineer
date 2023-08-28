The blocks necessary to properly test the ABRO state machine module are:
1. Testbench module: This module will instantiate the ABRO state machine module and provide stimulus inputs to test its functionality.
2. Clock generator: This block will generate the clock signal required for the ABRO state machine module.
3. Reset generator: This block will generate the active-low reset signal to reset the ABRO state machine module.
4. Monitor: This block will monitor the output of the ABRO state machine module and compare it with the expected output to determine if the test cases pass or fail.

Important edge cases to test in the testbench:
1. Test case where A and B are not entered in the correct order.
2. Test case where A is entered before B.
3. Test case where B is entered before A.
4. Test case where A and B are entered simultaneously.
5. Test case where A and B are entered multiple times in different orders.

Now, let's proceed with the testbench module.

testbench.v
