from quitter import Quitter
from tkinter import *
import random


class GuessMyNumber(Frame):
	"creates an app with a simple game to guess a number 1 to 10"
	def __init__(self, parent=None):
		Frame.__init__(self, parent)
		# game variables
		self.my_number = random.randint(1, 10)
		self.count = 0

		# create game directions
		lab = Label(self, text="I am thinking of a number 1 to 10...", width=40, height=1)
		labl = Label(self, text="Try to guess it in 3 tries!", width=40, height=1)
		lab.pack(side=TOP, fill=BOTH)
		labl.pack(side=TOP, fill=BOTH)

		# create results/hint window
		hint = Label(self, width=40, height=2)
		hint.pack(side=TOP, fill=BOTH)

		# create an entry for for your guess
		form = Frame(self)
		form.pack(side=TOP, fill=BOTH)
		ent_lab = Label(form, text="Your guess: ", width=10)
		ent_lab.pack(side=LEFT)
		var = IntVar()
		ent = Entry(form, textvariable=var, width=3)
		ent.pack(side=LEFT)	

		# creates button to check the guess/ enter game loop
		but = Button(form, text="Check", width=5, height=3, command=(lambda: self.turn(var.get(), hint)))
		but.pack(side=RIGHT, fill=X, expand=YES)

		# creates play again button
		new_game = Button(self, text='Play again!', command=(lambda: self.new_game(hint)))
		new_game.pack(side=TOP, fill=BOTH)

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
			tag.config(text='You win! :)')
		elif total == 3:
			tag.config(text='You lose! :(')
		else:
			if num > self.my_number:
				tag.config(text='Strikes: {}  Hint: guess lower...'.format(total))
			else:
				tag.config(text='Strikes: {}  Hint: guess higher...'.format(total))

	def new_game(self, tag):
		self.my_number = random.randint(1, 10)
		self.count = 0
		tag.config(text="I'm thinking of a new number.")


if __name__ == '__main__':
	root = Tk()
	root.title('Guess My Number!')
	gn = GuessMyNumber(root)
	gn.pack(side=TOP)
	root.mainloop()
