Looking at the output, it seems that Test 1 has failed. Test 1 is checking the functionality of the active-low reset. The testbench is expecting the rolled_number to be between 1 and 4 after the reset is deactivated, but it seems that this is not the case.

The issue might be due to the fact that the roll signal is not activated after the reset is deactivated. The DiceRoller module only updates the rolled_number when the roll signal is high. Therefore, we need to set the roll signal high after the reset is deactivated.

Here is the corrected testbench:

testbench.v
