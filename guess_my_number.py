import random

my_number = random.randint(1, 10)

def gameloop():
	print('I am thinking of a number 1 to 10...')
	print('Can you guess it in three tries or less?')
	total = 0
	guess = input('Guess my number => ')
	
	while total <= 2:
		if '.' in guess:
			guess = input('No decimals. Guess my number => ')
		if guess.isalpha():
			guess = input('Numbers only. Guess my number => ')
		if int(guess) >= 11:
			guess = input('1 to 10 please. Guess my number => ')
		if int(guess) <= 0:
			guess = input('1 to 10 please. Guess my number => ')

		guess = int(guess)
		if guess == my_number:
			print('You got it! You win!! :)')
			break
		elif total == 2:
			print('Sorry. You lose. :(')
			break
		else:
			total += 1
			if guess > my_number:
				print('(Hint: lower... ;)')
			else:
				print('(Hint: higher... ;)')
			guess = input('Guess again => ')

gameloop()