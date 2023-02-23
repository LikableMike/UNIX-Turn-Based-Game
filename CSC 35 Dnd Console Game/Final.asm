.intel_syntax noprefix
.data

## Michael Partridge CSC 35 Final Project

####My Assembly code for my very loosely DnD Themed turn based multiplayer text game. My Game includes 3 different player classes to choose each 
#### Having their own unique stats and move sets. Allowing up to 10 players but can easily be adjusted to hold more. Each attack has a different
#### "accuracy" meaning that it will have different values it must beat by generating a random number. Implemented input validation to restrict
#### the player from attacking themselves or a non existing player. Was also going to restrict the player from attacking already defeated players
#### but I thought it would be more funny to allow them to and print out a message.

### Use of Registers:
###	rax: Stores the total amount of players
###	rbx: Stores the index player for the Health Bar loops
###	rcx: Stores the current player
###	rdx: used for printing and clearing screens esc
###	r8: Used in Health Bar loops to store players current health
###	r9: Used in Health Bar loops to print Health Bar Characters until it equals r8
###	r10: Used to determine players class and find which attack they have
###	r11: Used to find accuracy of the chosen attack
###	r12: Stores target players health to apply damage or to determine if they are fainted durring attack phase
###	r13:  Apparently nothing anymore lol
###	r14: Also stores total players but decrements down every time a player dies and determines when the game is over
###	r15: Stores players Health to determine if they are dead to skip their turn and print that they are fainted
 

## ASCII arts

##Welcome Message
Welcome:
	.ascii " 	                          |>>>\n"
	.ascii "                                  |\n"
	.ascii "                    |>>>      _  _|_  _         |>>>\n"
	.ascii "                    |        |;| |;| |;|        |\n"
	.ascii "                _  _|_  _    \\\\.    .  /    _  _|_  _\n"
	.ascii "               |;|_|;|_|;|    \\\\:. ,  /    |;|_|;|_|;|\n"
	.ascii "               \\\\..      /    ||;   . |    \\\\.    .  /\n"
	.ascii "                \\\\.  ,  /     ||:  .  |     \\\\:  .  /\n"
	.ascii "                 ||:   |_   _ ||_ . _ | _   _||:   |\n"
	.ascii "                 ||:  .|||_|;|_|;|_|;|_|;|_|;||:.  |\n"
	.ascii "                 ||:   ||.    .     .      . ||:  .|\n"
	.ascii "                 ||: . || .     . .   .  ,   ||:   |       \\,/\n"
	.ascii "                 ||:   ||:  ,  _______   .   ||: , |            /`\\ \n"
	.ascii "                 ||:   || .   /+++++++\\    . ||:   |\n"
	.ascii "                 ||:   ||.    |+++++++| .    ||: . |\n"
	.ascii "              __ ||: . ||: ,  |+++++++|.  . _||_   |\n"
	.ascii "     ____--`~    '--~~__|.    |+++++__|----~    ~`---,              ___\n"
	.ascii "-~--~                   ~---__|,--~'                  ~~----_____-~'   `~----~~\n"
	.ascii "********************Welcome to Caverns and Creatures!**************************\n"
	.ascii "                       Created by Michael Partridge\n\n\0"

##Winner Screen
WinMessage:
	.ascii " WINS!!!!!!!!!\n\n"
	.ascii "                            ==(W{==========-      /===-                        \n"
	.ascii "                              ||  (.--.)         /===-_---~~~~~~~~~------____  \n"
	.ascii "                              | \\_,|**|,__      |===-~___                _,-' `\n"
	.ascii "                 -==\\\\        `\\ ' `--'   ),    `//~\\\\   ~~~~`---.___.-~~      \n"
	.ascii "             ______-==|        /`\\_. .__/\\ \\    | |  \\\\           _-~`         \n"
	.ascii "       __--~~~  ,-/-==\\\\      (   | .  |~~~~|   | |   `\\        ,'             \n"
	.ascii "    _-~       /'    |  \\\\     )__/==0==-\\<>/   / /      \\      /               \n"
	.ascii "  .'        /       |   \\\\      /~\\___/~~\\/  /' /        \\   /'                \n"
	.ascii " /  ____  /         |    \\`\\.__/-~~   \  |_/'  /          \\/'                  \n"
	.ascii "/-'~    ~~~~~---__  |     ~-/~         ( )   /'        _--~`                   \n"
	.ascii "                  \\_|      /        _) | ;  ),   __--~~                        \n"
	.ascii "                    '~~--_/      _-~/- |/ \   '-~ \\                            \n"
	.ascii "                   {\__--_/}    / \\_>-|)<__\      \\                           \n"
	.ascii "                   /'   (_/  _-~  | |__>--<__|      |                          \n"
	.ascii "                  |   _/) )-~     | |__>--<__|      |                          \n"
	.ascii "                  / /~ ,_/       / /__>---<__/      |                          \n"
	.ascii "                 o-o _//        /-~_>---<__-~      /                           \n"
	.ascii "                 (^(~          /~_>---<__-      _-~                            \n"
	.ascii "                ,/|           /__>--<__/     _-~                               \n"
	.ascii "             ,//('(          |__>--<__|     /  -Alex Wargacki  .----_          \n"
	.ascii "            ( ( '))          |__>--<__|    |                 /' _---_~\\        \n"
	.ascii "         `-)) )) (           |__>--<__|    |               /'  /     ~\\`\\      \n"
	.ascii "        ,/,'//( (             \\__>--<__\\    \\            /'  //        ||      \n"
	.ascii "      ,( ( ((, ))              ~-__>--<_~-_  ~--____---~' _/'/        /'       \n"
	.ascii "    `~/  )` ) ,/|                 ~-_~>--<_/-__       __-~ _/                  \n"
	.ascii "  ._-~//( )/ )) `                    ~~-'_/_/ /~~~~~~~__--~                    \n"
	.ascii "   ;'( ')/ ,)(                              ~~~~~~~~~~                         \n"
	.ascii "  ' ') '( (/                                                                   \n"
	.ascii "    '   '  `\n\n"
	.ascii "                               CONGRATULATIONS!!!!!!\n\n"
	.ascii "                               Thanks For Playing :)\n\0"	

###Different String messages used throughout the game

PlayerCount:
	.ascii "                     How many players would you like?\n\0"

SelectClass:
	.ascii " Choose your class!  (1 = Barbarian  2 = Wizard  3 = Rogue)\n\0"

Chose:
	.ascii " chose \0"

EndSelect:
	.ascii "Classes Selected\n\0"

Target:
	.ascii "Who would you like to target?\n\0"

Missed:
	.ascii "Attack Missed\n\0"

Hit:
	.ascii "Attack Landed\n\0"

Fainted:
	.ascii "**Fainted**\n\0"

SelfTarget:
	.ascii "Don't Attack Yourself!!!!\n\0"

DeadTarget:
	.ascii "They're.... super dead...\n\0"

DeadWhiff:
	.ascii "You... you missed an unmoving, already dead target......\n\0"

Next:
	.ascii "Hit Enter for next player \n \0"

Player:
	.ascii "Player \0"

##Displays error message for an invalid user input
invalidChoice:
	.ascii "Invalid Choice. Try Again\n\0"

##Stores the Character/command to clear the screen. I did not realize that there was a command for it already in the library :D
ClearScreen:
	.ascii "\033c\0"


##Chosen character to represent health
HealthChar:
	.ascii "=\0"
	.ascii "\n\0"
	.ascii " hp:\n\0"

##All Class Stats stored in the same order to allow for consistant access between classes. Names are stored last so I can move through the rest of the table
## with a constant number no matter what class the person is.

##Stores Barbarian stats
Barbarian:
	.quad 150			#Health
	.quad 15			#Atk 1
	.quad 25			#Atk 2
	.quad 20			#Atk 3
	.quad 35			#Atk 4
	.ascii "Barbarian(Consistent damage, High health)\n\n\0"	#Name	

bAtks:
	.ascii ":  1. Hammer		2. Reckless Swing	3. Charge		4. SMASH!!\n\0"

##Stores Wizard Stats
Wizard:
	.quad 80
	.quad 20
	.quad 30
	.quad 15
	.quad 95
	.ascii "Wizard (High damage, Low Health)\n\n\0"

wAtks:
	.ascii ":  1. Fire-Bolt		2. Magic-Missle		3. Thunder-Clap		4. Call-Lightning\n\0"

##Stores Rogue Stats
Rogue:
	.quad 100
	.quad 10
	.quad 40
	.quad 15
	.quad 70
	.ascii "Rogue(Medium damage, Medium health)\n\n\0"

rAtks:
	.ascii ":  1. Dagger		2. Sneak-Attack		3. Trip			4. Assassinate\n\0" 

##Stores the classes of all the players
PlayerClasses:
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0

##Sets up table to store all players health
PlayerHealth:
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0

.text
.global _start

##Clears screen and displays welcome message
_start:
	lea rdx, ClearScreen
	Call PrintZString

	lea rdx, Welcome
	Call PrintZString

##Allows input for how many players in the game (Up to 10 players)
Players:
	lea rdx, PlayerCount
	Call PrintZString
	Call ScanInt
	mov rax, rdx
	mov r14, rdx
	
	lea rdx, ClearScreen
	Call PrintZString	
	mov rbx, 0

##A loop to allow the players to select their classes
Select:
	cmp rbx, rax
	je Selected
	lea rdx, Player
	Call PrintZString
	mov rdx, rbx
	add rdx, 1
	Call PrintInt
	lea rdx, SelectClass
	Call PrintZString

	##Class Select switch statement
	Call ScanInt
	cmp rdx, 1
	je Barb
	cmp rdx, 2
	je Wiz
	cmp rdx, 3
	je Rog
	lea rdx, invalidChoice
	Call PrintZString
	jmp Select

##Once all players have selected their classes then we start the game loop
Selected:
	lea rdx, ClearScreen
	Call PrintZString
	sub rax, 1
	jmp GameLoop

##Stores players stats as Barbarian stats
Barb:
	lea rdx, ClearScreen
	Call PrintZString
	movq [PlayerClasses + 8 * rbx], 1
	mov rdx, [Barbarian]
	movq [PlayerHealth + 8 * rbx], rdx	
	add rbx, 1
	jmp Select

##Stores players stats as Wizard stats
Wiz:
	lea rdx, ClearScreen
	Call PrintZString
	movq [PlayerClasses + 8 * rbx], 2
	mov rdx, [Wizard]
	movq [PlayerHealth + 8 * rbx], rdx
	add rbx, 1
	jmp Select

##Stores players stats as Rogue stats
Rog:
	lea rdx, ClearScreen
	Call PrintZString
	movq [PlayerClasses + 8 * rbx], 3
	mov rdx, [Rogue]
	movq [PlayerHealth + 8 * rbx], rdx
	add rbx, 1
	jmp Select

##Sets font color to red and Prints "=" for each Hit-Point they have 
PrintHealth:
	mov rdx, 1
	Call SetForeColor
	lea rdx, HealthChar
	mov r8, [PlayerHealth + 8 * rbx]
	Call PrintZString
	add r9, 1
	cmp r9, r8
	jl PrintHealth
	mov rdx, 7
	Call SetForeColor
	lea rdx, [HealthChar + 2]
	Call PrintZString
	ret

##Resets counters and falls through to the rest of the game loop
GameLoop:
	mov rbx, 0
	mov rcx, 0

## Loops through all players and prints their current health my printing a character once for every hit-point they have
## also counts how many dead players there are and subtracts it from the total number of players. If everyone is dead
## except 1 player then it jumps to a win function
HealthBar:
	cmp r14, 1
	jle WinnerStart
	cmp rbx, rax
	jg Battle
	lea rdx, Player	
	Call PrintZString
	mov rdx, rbx
	add rdx, 1
	Call PrintInt
	lea rdx, [HealthChar + 4]
	Call PrintZString
	mov r9, 0
	Call PrintHealth
	mov r15, [PlayerHealth + 8 * rbx]
	Call Dead
	add rbx, 1
	jmp HealthBar

##Determines if the players health is below 0
Dead:
	cmp r15, 0
	jle pFaint
	ret

##Shows the player is fainted
## Kind of janky but updates r15 to arbitrary value above 0 so it can jump back to Dead: and return to the spot it was called.
pFaint:
	sub r14, 1
	lea rdx, Fainted
	Call PrintZString
	mov r15, 9999
	jmp Dead	

## Battle loop 
Battle:
	##Resets tracker variables
	mov rbx, 0
	mov r14, rax
	add r14, 1

	##Checks of the current player is still alive
	mov r15, [PlayerHealth + 8 * rcx]
	cmp r15, 0
	jle battleReturn

	##Prints current player
	lea rdx, Player	
	Call PrintZString
	mov rdx, rcx
	add rdx, 1
	Call PrintInt

	#Prints available moves for current players class
	Call FindMoves

	#Choose Which attack to use and which target then reruns the loop for the other players
	Call UseAtk
	Call ChooseTarget
	Call battleReturn

battleReturn:
	#Refreshes screen to show current health bars and increments the current player up one unless we 
	#have gone through all players then reruns the entire game loop
	lea rdx, ClearScreen
	Call PrintZString
	add rcx, 1
	cmp rcx, rax
	jle HealthBar
	jmp GameLoop


##Loop that holds other loops for choosing a target
ChooseTarget:

##Reads players input and decrements it by one to match the index number of targeted player
Input:
	##Prints message to tell player to attack
	lea rdx, Target
	Call PrintZString
	Call ScanInt
	sub rdx, 1
	cmp rdx, -1
	je Input

	## Jumps to a landed hit as long as they didnt attack the current player (Themselves)
	cmp rdx, rcx
	jg Pass
	jl Pass

	##Prints message if they tried to attack themself and makes htem re-choose
	lea rdx, SelfTarget
	Call PrintZString
	jmp Input

##Input Validation
Pass:
	mov r8, rdx

	##Finds the accuracy of the chosen attack and randomly determines if the attack hits the targeted player
	Call FindAccuracy 
	Call Random 
	cmp rdx, 5
	jge Success
	jl Fail
	ret
	 
##Finds the possible moves for current players class
FindMoves:
	mov r10, [PlayerClasses + 8 * rcx]
	cmp r10, 1
	je B
	cmp r10, 2
	je W
	cmp r10, 3
	je R
	ret

##Has to determine which class the player has to display the right attacks
B:
	lea rdx, bAtks
	Call PrintZString
	ret
W:
	lea rdx, wAtks
	Call PrintZString
	ret
R:
	lea rdx, rAtks
	Call PrintZString
	ret
	
##Reads users input and determines which attack they chose and stores its damage on hit
UseAtk:
	Call ScanInt
	cmp rdx, 1
	je Move1
	cmp rdx, 2
	je Move2
	cmp rdx, 3
	je Move3
	cmp rdx, 4
	je Move4
	
	##Makes them rechoose if the attack doesn't exist
	lea rdx, invalidChoice
	Call PrintZString
	jmp UseAtk

## Determines what class the current player is so it knows which attack to use
Move1:
	cmp r10, 1
	je Ba
	cmp r10, 2
	je Wa
	cmp r10, 3
	je Ra		
	
Move2:
	cmp r10, 1
	je Ba
	cmp r10, 2
	je Wa
	cmp r10, 3
	je Ra

Move3:
	cmp r10, 1
	je Ba
	cmp r10, 2
	je Wa
	cmp r10, 3
	je Ra

Move4:
	cmp r10, 1
	je Ba
	cmp r10, 2
	je Wa
	cmp r10, 3
	je Ra
	

## Move stores the chosen attacks damage in order to apply it to the targets health
Ba:
	mov r10, [Barbarian + 8 * rdx]
	mov r11, rdx
	ret

Wa:
	mov r10, [Wizard + 8 * rdx]
	mov r11, rdx
	ret

Ra:
	mov r10, [Rogue + 8 * rdx]
	mov r11, rdx
	ret

##Find and stores accuracy of chosen attack
## Accuracy is determined by storing a number in rdx, then generating a random number from zero to that stored number, then comparing that new number to 5.
## if the random number is greater than 5 then the attack should hit therefore the higher the number stored in rdx the greater chance it has to hit.
FindAccuracy:
	cmp r11, 1
	je m1
	cmp r11, 2
	je m2
	cmp r11, 3
	je m3
	cmp r11, 4
	je m4
	
m1:
	mov rdx, 25
	ret
m2:
	mov rdx, 10
	ret
m3:
	mov rdx, 15
	ret
m4:
	mov rdx, 6
	ret


#Applies damage and prints message informing the player that is succeeded
Success:	
	
	mov r12, [PlayerHealth + 8 * r8]
	cmp r12, 0
	jle DeadHit
	sub r12, r10
	movq [PlayerHealth + 8 * r8], r12
	lea rdx, Hit
	Call PrintZString
Ret:
	lea rdx, Next
	Call PrintZString
	Call ScanInt
	ret

## Prints message saying you attacked an already dead character
DeadHit:
	lea rdx, DeadTarget
	Call PrintZString
	jmp Ret

##Does Not apply damage and prints message informing the player that the attack missed
Fail:
	mov r12, [PlayerHealth + 8 * r8]
	cmp r12, 0
	jle DeadMiss
	lea rdx, Missed
	Call PrintZString
Ret2:
	lea rdx, Next
	Call PrintZString
	Call ScanInt
	ret

## Prints a message when the player decides to attack a dead player and misses :D
DeadMiss:
	lea rdx, DeadWhiff
	Call PrintZString
	jmp Ret2


## Functions used to print the win screen
WinnerStart:
	lea rdx, ClearScreen
	Call PrintZString
	mov rdx, 0

##Loops through all players and compares their health to 0. The first player that has more than 0 is the winner.
Winner:
	mov rcx, [PlayerHealth + 8 * rdx]
	cmp rcx, 0
	jg DecideWinner
	add rdx, 1
	jmp Winner

##Displays Winner Screen
DecideWinner:
	mov rax, rdx
	add rax, 1
	lea rdx, Player
	Call PrintZString
	mov rdx, rax
	Call PrintInt
	lea rdx, WinMessage
	Call PrintZString

End:
	Call Exit
