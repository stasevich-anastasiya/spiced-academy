"""
Exercises: Rock Paper Scissors
Step 1: Alternative Decisions

Insert the words elif, else and if into the gaps in the code so that it runs:

import random

player = input("Please enter R, P or S (for [R]ock, [P]aper and [S]cissors) ")
computer = random.choice('RPS')

____ player == 'R' and computer == 'P':
    print("Computer wins")
____ player == 'R' and computer == 'S':
    print("Player wins")
____:
    print("it's a draw")
    """
# Step 1: Alternative Decisions

# Step 2: Paper
# Extend the program, so that it also works if the player chooses paper or scissors.

"""import random

player = input("Please enter R, P or S (for [R]ock, [P]aper and [S]cissors) ")
computer = random.choice('RPS')

if player == 'R' and computer == 'P':
    print("Computer wins")
elif player == 'R' and computer == 'S':
    print("Player wins")

elif player == 'P' and computer == 'S':
    print("Computer wins")
elif player == 'P' and computer == 'R':
    print("Player wins")

elif player == 'S' and computer == 'P':
    print("Player wins")
elif player == 'S' and computer == 'R':
    print("Computer wins")
else:
    print("it's a draw")
    """

# Step 3: Debugging
# Copy the code into a text file. Reorder and debug the code until it runs with no errors:
"""
player = input('Please enter R, P or S (for [R]ock, [P]aper and [S]cissors): ')

elif player.upper() not in 'RPS':
    print('Invalid input. Please enter R,P or S.')

elif player == computer
    print('You chose the same as I did')

if player = 'S':
    print('You chose "scissors".')

computer = 'P'

else:
print('You chose something else than "scissors"')
"""
computer = 'P'
player = input('Please enter R, P or S (for [R]ock, [P]aper and [S]cissors): ')

if player = 'S':
    print('You chose "scissors".')
elif player == computer
    print('You chose the same as I did')
elif player.upper() not in 'RPS':
    print('Invalid input. Please enter R,P or S.')
else:
print('You chose something else than "scissors"')
