AUTHOR: Matthew King
CONTENT: MIPS Programming Assignment 2

Assignment 2 Algorithm
----------------------
START
Read userString +2 more than they're allowed to enter
Start at first character
WHILE (curChar != (NULL || NEWLINE)) while not at the end of the string
	Call TrimString
	Call ValidityCheck

		IF valid run convert-to-decimal with the passed start and end addresses
		ELSE print NAN instead
END

TrimString: Passed start of string
	Mark first NON-SPACE character as the start of the string
	Mark first comma/newline/null character as the end of the string
	From the comma/newline/null marker WHILE character-before-marker is a space:
		shift marker back one position
		(Must ensure that the start of string isn't passed)
	Return start and end of string

ValidityCheck: Passed start and end of string
	currentChar = start
	counter = 0
	<Check to ensure there are no spaces inside the string>
	<Set the start and end markers to the first and last characters>
	<Count the distance between start and end>
	IF there are spaces in between return that string is invalid
	currentChar = start
	digitTracker = 0
	WHILE digitTracker != 0
		IF currentChar is not(0-9,A-F,a-f) THEN
			RETURN that string is invalid
	return that string is valid, and the number of digits

Thoughts:
---------
Will utilize the convert-to-decimal string for each substring.
Performs convert-to-decimal on a each set of numbers until the string as a whole is done

SUB1: Converts HEX character to its DEC value (eg. B -> 11). Takes/returns values with registers

SUB2: Converts HEX String into DEC integer. Takes values via register, returns values via stack. Calls SUB1

SUB3: Outputs integers as unsigned. Takes values via stack. Similar to prev. output but must take from stack until end-value is reached
