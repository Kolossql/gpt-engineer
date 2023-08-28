Blocks necessary for testing the module:
1. Testbench module: This module will instantiate the binary to BCD converter module and provide stimulus to its inputs. It will also monitor the outputs and compare them with the expected values.

Important edge cases to test:
1. Input binary number 0 (00000)
2. Input binary number 31 (11111)
3. Input binary number with all bits set to 1 (11111)
4. Input binary number with all bits set to 0 (00000)
5. Random input binary number

Testbench module code:

testbench.v
