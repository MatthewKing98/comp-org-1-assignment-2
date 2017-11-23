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
		
	newLine:
		.asciiz "\n"

#####################################################
# MODULE: main                                      #
# PURPOSE: Initial driver for code                  #
# $s0 CONST End of string - END                     #
# $s1 CONST Maximum size of string - STRSIZE        #
# $s2 CONST Input Base - INBASE                     #
# $s3 CONST Output Base - OUTBASE                   #
# $s4 CONST Space - SPACE                           #
# $s5 CONST Comma - COMMA
# $t0 Cumulative sum - cumulativeSum                #
# $t1 Address of decimal in string form - deciString#
#####################################################
	.text
main:
	#variables intialized
	li $s0, 10 #CONST END = 10
	li $s1, 1000 #CONST STRSIZE = 1000
	li $s2, 16 #CONST INBASE = 16
	li $s3, 10 #CONST OUTBASE = 10
	li $s4, 32 #CONST SPACE = 32
	li $s5, 44 #CONST COMMA = 44
	
input:
	li $a1, 1000 #Specify max size for read string read characters = ($a1 - 1) = 8 max
	la $a0, userInput #Set destination for read string
	li $v0, 8 #Read String code loaded
	syscall #Read string from user
	jal CheckSpaces
	
output:
	la $a0, newLine #Set output source to cumulativeSum
	li $v0, 4 #Output String code loaded
	syscall	#Output unsigned cumulative sum as a string

	la $a0, userInput #Set output source to cumulativeSum
	li $v0, 4 #Output String code loaded
	syscall	#Output unsigned cumulative sum as a string
	
exit:
	li $v0, 10 #Exit code loaded
	syscall	#Exit program
	
#####################################################
# MODULE: TrimString                                #
# PURPOSE: returns individual hexadecimal string    #
# $a0 Start of substring
# $t0 current character address of substring
# $t1 current character
# $t2 current comparison
# $t3 string status
# $t4 trimmed start of substring
# $t5 trimmed end of substring
# $t6 invalid number marker
# >>> CODE
# >>> 0 - First read (no spaces or numbers)
# >>> 1 - Contains only numbers (non-spaces)
# >>> 2 - Contains only spaces
# >>> 3 - Contains number followed by a space
# >>> 4 - Invalid

CheckSpaces:
	add $t0, $a0, $zero #load address of first character
	add $t4, $t0, $zero #marks inclusive start of string
	add $t3, $t3, $zero #load "first read" status
	CheckSpacesLoop:
		lb $t1, 0($t0) #load character
		beq $t1, $s5, CheckSpacesEnd #end if character is end-of-string
		beq $t1, $s0, CheckSpacesEnd #end if character is comma
		beq $t1, $zero, CheckSpacesEnd # end if character is null
		bne $t1, $s4, isNotSpace
		isSpace:
			li $t2, 0
			beq $t3, $t2, wasBlankAddSpace #branch if previously unset
			li $t2, 1
			beq $t3, $t2, wasNumAddSpace #branch if previously just number
			li $t2, 2
			beq $t3, $t2, wasSpaceAddSpace #branch if previously just space
			li $t2, 3
			beq $t3, $t2, wasNumAndSpaceAddSpace #branch if previously just space
			
			li $a0, 8
			li $v0, 1
			syscall
			
		isNotSpace:
			li $t2, 0
			beq $t3, $t2, wasBlankAddNum #branch if previously unset
			li $t2, 1
			beq $t3, $t2, wasNumAddNum #branch if previously just number
			li $t2, 2
			beq $t3, $t2, wasSpaceAddNum #branch if previously just space
			li $t2, 3
			beq $t3, $t2, wasNumAndSpaceAddNum #branch if previously just space
		
		
		wasBlankAddSpace:
			li $t3, 2 #blank -> space
			j nextNo
		wasNumAddSpace:
			li $t3, 3 #num -> numAndSpace
			add $t5, $t0, $zero #marks exclusive end of string
			j nextNo
		wasSpaceAddSpace:
			j nextNo
		wasNumAndSpaceAddSpace:
			j nextNo
			
		wasBlankAddNum:
			li $t3, 1 #blank -> num
			add $t4, $t0, $zero
			j nextNo
		wasNumAddNum:
			add $t5, $t0, $zero #marks exclusive end of string
			j nextNo
		wasSpaceAddNum:
			li $t3, 1 #blank -> num
			add $t4, $t0, $zero #marks inclusive start of string
			j nextNo
		wasNumAndSpaceAddNum:
			li $t6, 1
			j CheckSpacesEnd
		
		nextNo:
			addi $t0, $t0, 1 #advance to next character
			j CheckSpacesLoop
	
CheckSpacesEnd:
	la $a0, newLine #Set output source to cumulativeSum
	li $v0, 4 #Output String code loaded
	syscall	#Output unsigned cumulative sum as a string
	lb $t1, 0($t4)
	add $a0, $t1, $zero
	li $v0, 11 #Output char code loaded
	syscall	#
	la $a0, newLine #Set output source to cumulativeSum
	li $v0, 4 #Output String code loaded
	syscall	#Output unsigned cumulative sum as a string
	lb $t1, 0($t5)
	add $a0, $t1, $zero
	li $v0, 11 #Output char code loaded
	syscall	#
	la $a0, newLine #Set output source to cumulativeSum
	li $v0, 4 #Output String code loaded
	syscall	#Output unsigned cumulative sum as a string
	jr $ra #end of function
