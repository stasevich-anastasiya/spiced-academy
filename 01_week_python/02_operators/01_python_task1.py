""" Task 1 - White Rabbits

In April you have 10 white rabbits:
rabbits = 10
The rabbits constantly multiply. Every month, their number grows by 20%. In May you already have 12 rabbits. How many rabbits will you have in December?
"""

rabbits = 10

# -- N O T E S --
# 20% grows means multiplication to 1.2 each month
# April to Dezember: there are 8 times growth (8 iterations)

# Version 1 - Assumption that each month there could be only INT number of rabbits
#for i in range(8):
#   rabbits = int(rabbits * 1.2)
#   print (f'Iteration number \'{i+1}\'. There are currently {rabbits} rabbits.') 

# Version 2 - Assumption that only INT number of rabbits should be finally
for i in range(8):
   rabbits = rabbits * 1.2
   print (f'Iteration number \'{i+1}\'. There are currently {int(rabbits)} rabbits.')
