#Exercises: Your first program
#In this walk-through you will write your first python program, fix bugs and output results on the terminal.

#-----------------------------------------------------------
#Step 1: Your first program

# Create a new file name.py in the text editor and enter the following instructions:
"""name = input("What is your name? ")
print(f'Hello {name}!')
"""
#------------------------------------------------------------
# Step 2: Break the program!

# When programming, it is inevitable that you make mistakes. Errors can be simple typos or complicated errors in the logical structure. One of the most important skills in programming is to find the cause of a bug in a program and fix it. You can practice this by intentionally breaking the program and seeing what happens.
# Try the following programs with errors one by one and try to understand the error message:
"""
name = input("What is your name? ")
pront("Hello", name)                    # NameError: name 'pront' is not defined

#FIX: Should be: print("Hello", name)

name = input("What is your name? "      # SyntaxError: '(' was never closed
print("Hello", name)

#FIX: Should be: name = input("What is your name? ")

name = input("What is your name? ")
print(Hello , name)                     # NameError: name 'Hello' is not defined

#FIX: Should be: print("Hello" , name)

x = input("What is your name? ")        # No errors!
print("Hello", x)
"""

# --------------------------------------------------------------

# Step 3: input
"""
Which of the following input commands work? Try them one by one.

name input("enter your name: ")     #SyntaxError: invalid syntax # FIX: Add '=' between variable name and the function
name = input("enter a number: ")    # Works correctly!
name = input(enter your name)       # SyntaxError: invalid syntax. Perhaps you forgot a comma? # FIX: Add quotes to the argument
name = input()                      # Works OK, but the User do not understand what to do

"""

#---------------------------------------------------------------

# Step 4: Debugging
# The following program should output a song by Bob Marley. It contains three bugs. Find and fix them.
"""
part1 = "Don't worry about a thing"
part2 = "Cause every little thing"
part3 = gonna be all right

text = "part1 + part2 + part3"
print(text
"""
# Fixed
"""
part1 = "Don't worry about a thing"
part2 = "Cause every little thing"
part3 = "gonna be all right"            # quotes for string are needed

text = part1 + part2 + part3            # no quotes are needed
print(text)                             # close the brackets
"""

#------------------------------------------------------------

# Step 5: Extend your program
"""
    * Write a program that asks for your first and last name
    * Output both in uppercase letters
    * Also ask for your age
    * Combine the output using a f-string
"""

name = input("What is your last name? ")
first_name = input("What is your first name? ")
print(f'Hello {first_name.upper() + ' ' + name.upper()}!')
age = input("What is your age? ")
print(f'{first_name.upper() + name.upper()}, you are {age} years old!')
