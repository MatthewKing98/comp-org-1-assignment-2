############################################################
############################################################
## AUTHOR: Matthew King                                   ##
## COURSE: Computer Organization I                        ##
## PROGRAM: ASSIGNMENT 2                                  ##
## FUNCTION: Converts strings of Hex to strings of Dec    ##
############################################################
############################################################

.data
	userInput: #location were valid entry is stored
		.space 1001 #9 bytes, 1 byte per possible character, and an end-of-string marker; Space is maximum size
		
	outputDecimal: #string version of number (stored here because the 32 bit register represents 2s compliment vs unsigned)
		.space 10 #Largest expected value is 4294967295 (FFFFFFFF); 10 digits long
