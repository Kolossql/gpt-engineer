The necessary blocks for testing the Verilog module are as follows:

1. Testbench module: This module will instantiate the binary to BCD converter module and provide stimulus to its inputs. It will also verify the correctness of the output BCD values.

The important edge cases to be tested in the testbench are as follows:

1. Minimum input value (0): Test the conversion of the minimum input value (0) to BCD.
2. Maximum input value (255): Test the conversion of the maximum input value (255) to BCD.
3. Random input value: Test the conversion of a random input value (e.g., 123) to BCD.
4. Input value with leading zeros: Test the conversion of an input value with leading zeros (e.g., 00101010) to BCD.
5. Input value with all ones: Test the conversion of an input value with all ones (e.g., 11111111) to BCD.

Now, let's proceed with the implementation of the testbench module:

**testbench.v**
