# Task 1 - Find the condition 
# 1-1
"""a=5
while a!=0: 
    a=a-1
    print('Step number ',a)"""

# 1-2
"""a = 2
while abs(a)<7:
    a = -a*2
    print(a)"""

# 1-3
"""a = 2
while a<19:
    a+=4
    print(a)"""

# 1-4
"""a=7
while a>=0:
    a-=2
    print(a)"""

#----------------------------------------------
# TASK 2

#a=1
#while a = 1: #SyntaxError: invalid syntax. Maybe you meant '==' or ':=' instead of '='?

#b=1
#while b == 1 #SyntaxError: expected ':'

#a=2
#while a + 7: # it works!
    #print('Works!')

#c='spiced'
#while len(c) > 10: # it works!
    #print('Works!')

"""a = True
b = 2
c = 0
while a and (b-2 == c): # valid, but infinite loop!
    print(a)
    """
"""s = 'spied'
print(s.find('c')) # len = 3 or len = -1 when is not found
while s.find('c') >= 0: # it works!
    print(s)"""


#--------------------------------------------------------
# TASK 3

"""
Which statements are correct?

    * while is also called a conditional loop                   # True
    * The expression after while may contain function calls     # True
    * It is possible to have while loops that run forever       # True
    * The colon after while may be omitted                      # False
    * The code block after while is executed at least once      # ??


"""

#--------------------------------------------------------
# TASK 4

data = [5, 7, 33, 12, 4, 3, 18] # len = 7

found = False
i=0 #counter

while i < len(data) and not found:
    if data[i] == 33:
        found = True
        print(f"The value 33 has been found: {found}")
        #break
    else:
        print(f"Current position is {i}. Value is {data[i]}. The value 33 has been found: {found}")
        i+=1


#--------------------------------------------------------
# Task 5

#Which of the following while loops will finish?

#A - the loop will finish
"""count = 0
while count > 0:
    print(count)
    count += 1
    """
    

#B - infinite loop!
"""text = "a"
while "z" not in text:
    text += "a"
    #print(f"Text = {text}.")
    """

#C - Infinite loop!
"""a = 7
b = 135
while a != b:
    a += (a - b) / 10.0
    b -= (a - b) / 10.0
    #print(f"Current a = {a}, current b = {b}.")
    """

#D - the loop will finish
"""
n = 0
while n * 5 != n ** 2:
    n += 2
    print('Some test text.')
    """
