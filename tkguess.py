import random
from quitter import Quitter
from tkinter import *


class GuessMyNumber(Frame):
	"creates an app with a simple game to guess a number 1 to 10"
	def __init__(self, parent=None):
		Frame.__init__(self, parent)

		# game variables
		self.my_number = random.randint(1, 10)
		self.count = 0

		# create game directions
		lab = Label(self, text="I am thinking of a number 1 to 10...")
		lab.config(width=40, bg='blue', fg='white')
		labl = Label(self, text="Try to guess it in 3 tries!")
		labl.config(width=40, bg='blue', fg='white')
		lab.pack(side=TOP, fill=BOTH, pady=10)
		labl.pack(side=TOP, fill=BOTH, pady=5)

		# create results/hint window
		hint = Label(self, width=40, bg='orange', fg='white')
		hint.pack(side=TOP, fill=BOTH, pady=10)

		# create an entry for for your guess
		form = Frame(self)
		form.pack(side=TOP, fill=BOTH)
		ent_lab = Label(form, text="Your guess: ", width=10)
		ent_lab.pack(side=LEFT, padx=10)
		var = IntVar()
		ent = Entry(form, textvariable=var)
		ent.config(width=10, bg='lemon chiffon', fg='red')
		ent.pack(side=LEFT)

		# creates button to check the guess/ enter game loop
		but = Button(form, text="Check", width=10)
		but.config(command=(lambda: self.turn(var.get(), hint)))
		but.pack(side=RIGHT, fill=X, padx=10)

		# creates play again button
		new_game = Button(self, text='Play Again')
		new_game.config(command=(lambda: self.new_game(hint)))
		new_game.pack(side=TOP, fill=BOTH, expand=YES, padx=10, pady=5)

		# creates quit button
		quit = Quitter(self)
		quit.pack(side=TOP, fill=BOTH)

	def counter(self):
		"keeps track of the number of guesses"
		self.count += 1
		return self.count

	def turn(self, num, tag):
		"gameloop to guess a number 1 to 10 in 3 tries"
		# count the guesses
		total = self.counter()
		# if num == my_number:
		if num == self.my_number:
			# display win state
			tag.config(text='You win! :)', bg='firebrick')
		elif total == 3:
			tag.config(text='You lose! :(', bg='dodger blue')
		else:
			if num > self.my_number:
				tag.config(text='Strikes: {}  Hint: guess lower...'.format(total))
			else:
				tag.config(text='Strikes: {}  Hint: guess higher...'.format(total))

	def new_game(self, tag):
		"resets the widget for a new game of guess the number"
		self.my_number = random.randint(1, 10)
		self.count = 0
		tag.config(text="I'm thinking of a new number.", bg='orange')


if __name__ == '__main__':
	root = Tk()
	root.title('Guess My Number!')
	gn = GuessMyNumber(root)
	gn.pack(side=TOP)
	root.mainloop()
