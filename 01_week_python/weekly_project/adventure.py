"""Far, far away, in an hardly accessible landscape, the mighty Data Medal lies hidden. Will you find the Medal and unlock the Power of Data Analytics?

    * the medal can be found on a lonely clearing
    * to unlock the medal, you need a magic spell
    * the spell is only known to a mage
    * the mage lives in a tower behind the forest
    * in the forest lives a bear that doesn’t let anyone pass
    * the bear, however, loves honey. Fortunately there is a beekeeper nearby.
"""
# Variables definition
rooms = ['hometown', 'clearing', 'beekeeper', 'tower', 'forest'] # List of valid ROOMS
room = 'hometown'       # str: initial room
new_room = 'hometown'
pot_of_honey = False    # bool: this flag defines if a player has a pot of honey
magic_spell = False     # bool: this flag defines if a player has a magic spell
medal = False           # bool: this flag defines if a player has unlocked the medal; is using to exit the loop
play = 'y'             # 'y' or 'n' : this flag defines if a player wants to play once again; user must to play at least once!

descriptions = {
    "hometown": "You are in your home town. \nA small trading spot at the desert border.",
    "clearing": "You are on a Lonely clearing. \nYou have found the Medal, but it's locked! \nGet the magic spell from the mage. He lives in the tower behind the forest.",
    "clearing_with_spell": "You are on a Lonely clearing. \nYou have unlocked the Medal with the magic spell!",
    "beekeeper": "You came to the beekeeper. \nYou buy a pot of honey at the beekeeper.",
    "tower": "You are in the tower. Here lives the mage. \nYou get the magic spell from him. \nNow you are able to unlock the Medal!",
    "forest": "There is a BEAR in the forest!!! You run away.",
    "forest_with_honey": "You leave the honeypot to the bear and carefully sneak through.",
    "wrong_location": "There is no such place! \nPlease select another!"
    #"wrong_location": "There is no such place! \nPlease select another (hometown, beekeeper, clearing, forest or tower)."
}

# Dictionary of possible destinations for each current location 
routes = {
    "hometown": ["beekeeper", "clearing", "forest"],
    "forest": ["beekeeper", "hometown"],                # the player can go throug the forest only having pot of honey
    "forest_with_honey": ["beekeeper", "tower", "hometown"],
    "tower": ["clearing", "hometown"],
    "beekeeper": ["forest", "hometown"],
    "clearing": ["hometown"]
}

# Asking for the player name
name = input('What is your name? ').upper()

print(f"Welcome {name} to ADVENTURE GAME! \nYou can travel around between multiple rooms: \n{', '.join(rooms)}. \nFind the medal!\n")

# outer loop start
while play == 'y':

    # Printing out the initial location for a player
    print(f"You are in \'{room}\'.")

    # loop start
    while not medal:

        #if new_room in routes:
        print('You can travel to ' + ', '.join(routes[room]) + '.')

        # asking a player to move to the new ROOM
        new_room = input("Where would you like to go? ")
        new_room = new_room.lower() # makes also valid room values like 'Forest' and 'FOREST'

        # checkin if new ROOM is a valid location
        #if new_room not in rooms: # old code
        if new_room not in routes.get(room): # ERROR !!!
            #print(descriptions["wrong_location"])
            #print("There is no such place! \nPlease select another (" + ', '.join(routes[room]) + ").") # gives dups with line 56
            print("There is no such place!")
            continue # program goes to the loop start

        # flags update based on location
        if new_room == 'beekeeper':
            pot_of_honey = True
        elif new_room == 'tower':
            magic_spell = True
        elif new_room == 'forest_with_honey':
            pot_of_honey = False
        
        # update new_room value depending on flag values
        if new_room == "clearing" and magic_spell:
            new_room = "clearing_with_spell"
            medal = True # flag to exit the loop: the player has reached the target location and unlocked the medal
        elif new_room == "forest" and pot_of_honey:
            new_room = "forest_with_honey"

        # printing new location description
        print(descriptions[new_room])

        # To solve routes issue
        room = new_room

    # Printing congratulations to the winner
    print(f"Congrats {name}! Your quest has been successful!")
      
    # end of the loop

    # Asking if the player wants to play again
    play = input('\nWould you like to play one more time? [y , n] : ').lower()

    # Proceed asking until the player gives 'y' or 'n'PLAY
    while play not in ['y', 'n']: # in'yn' is also correct
        play = input(f"Your answer is '{play}'. Please say 'y' or 'n' :").lower()
    
    # Analysing play value
    if play == 'y':
        medal = False # Reset the medal flag to be able to play again
        pot_of_honey = False
        magic_spell = False
        room = 'hometown'
        new_room = 'hometown'
        continue # start the outer loop (the whole play) from the beginning
    else: # Option play == 'n'
        break # complete this game and exit the program

# end of the outer loop

print('G A M E  O V E R !')
