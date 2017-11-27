AUTHOR: Matthew King
CONTENT: MIPS Programming Assignment 2

Assignment 2 Algorithm
----------------------
START
Read userString +2 more than they're allowed to enter
Start at first character
WHILE (curChar != (NULL || NEWLINE)) while not at the end of the string
	print CalculateValue //sub 3
END


CalculateValue: //sub 2
1. CumulativeSum = 0
2. Exponent = 0
3. Accept input up to comma/newline/null
4. Check if data is valid
	4.1 Contains numbers and/or letters going from 0-9 AND (a-f)/(A-F)
5. If data is valid THEN
	5.1 While there is content (while STRING != 000....000)
		5.1.1 Take the rightmost character from the string
		5.1.2 Translate it to decimal //sub 1
		5.1.3 Multiply it by 16^Exponent
		5.1.4 Add it to CumulativeSum
		5.1.5 Add 1 to Exponent
	5.2 Return CumulativeSum, and currChar
ELSE
	Return NaN, and currChar

Thoughts:
---------
There's no need to retype large amounts of the function. I just need to put what I already have in a loop.

STEPS:
> Make SUB1 be an exclusive function
> Make code for stack (eg No./VALID?/No./VALID?/STACKAMT)


SUB1: Converts HEX character to its DEC value (eg. B -> 11). Takes/returns values with registers

SUB2: Converts HEX String into DEC integer. Takes values via register, returns values via stack. Calls SUB1

SUB3: Outputs integers as unsigned. Takes values via stack. Similar to prev. output but must take from stack until end-value is reached


STACK LOGIC:
stack will need to be reversed before data is accessed

STACK BEFORE:
4|num
 |valid-code 
-
3|num 
 |valid-code
-
2|num
 |valid-code
-
1|num
 |valid-code
-
numberCount

STACK AFTER:
STACK BEFORE:
1|num
 |valid-code 
-
2|num 
 |valid-code
-
3|num
 |valid-code
-
4|num
 |valid-code
-
numberCount
