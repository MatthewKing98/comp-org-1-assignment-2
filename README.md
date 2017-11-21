AUTHOR: Matthew King
CONTENT: MIPS Programming Assignment 2

Assignment 2 Algorithm
----------------------
START
Read userString
Start substring at first non-space character
Mark the end of the substring at the end of the number (signified by a comma, \n, or NULL)
Trim possible spaces on RHS of substring
Test string for validity
	IF valid run convert-to-decimal with the passed start and end addresses
	ELSE print NAN instead
END
Thoughts:
---------
Will utilize the convert-to-decimal string for each substring.
Performs convert-to-decimal on a each set of numbers until the string as a whole is done
