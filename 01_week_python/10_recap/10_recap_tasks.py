# Self-test

#----------------------------------------------------------------------
# Easy

# You have the following variable:
# In [1]: code = 684
# Multiply this number by 10, substract 1, and divide by 7. As a result, you obtain the number of babies having the name “Walter” in 2014.

code = 684
code = int((code*10 -1)/7)
print(code)

# RESULTS: 977

#----------------------------------------------------------------------
#Medium

# You have the following variable:
# In [1]: name = "Walter White"
# Extract both initials from the string and store them to a new variable.

name = "Walter White" # original task value
name = "Walter Heisenber White" # extended value to show thw solution works for any amount of space-separated values
new_name = ''.join([s[0] for s in name.split()])
print(new_name)

# V2
x = name[0]
for i in range(len(name)):
    if name[i] == ' ':
        # print(i,name[i+1]) # DEBUG info
        x += name[i+1]
        # print(x) # DEBUG
print(x)

# RESULTS: WW

#----------------------------------------------------------------------
# Hard

# Store the following three lines in three separate string variables. Then concatenate them to one variable:
#       In the year 2014
#       977 Babys having the name 'Walter'
#       were born in the U.S.

# solution for a limited set of separate str values
str1 = "In the year 2014"
str2 = "977 Babys having the name 'Walter'"
str3 = "were born in the U.S."
str_res = str1 + ' ' + str2 + ' ' + str3
print(str_res)

# RESULTS: In the year 2014 977 Babys having the name 'Walter' were born in the U.S.

# V2 - Solution for a list of strings of any ampunt of elements

strings = ["In the year 2014",
"977 Babys having the name 'Walter'",
"were born in the U.S."]

concat_str = ' '.join(strings)
print(concat_str)
