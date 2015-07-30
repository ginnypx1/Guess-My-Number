from tkinter import *
import random


class GuessMyNumber(Frame):
	"creates an app with a simple game to guess a number 1 to 10"
	def __init__(self, parent=None):
		Frame.__init__(self, parent)
		self.my_number = random.randint(1, 10)
		self.count = 0

		# create game directions
		lab = Label(self, text="I am thinking of a number 1 to 10...", width=40, height=1)
		labl = Label(self, text="Try to guess it in 3 tries!", width=40, height=1)
		lab.pack(side=TOP, fill=BOTH)
		labl.pack(side=TOP, fill=BOTH)

		# create an entry for for your guess
		form = Frame(self)
		form.pack(side=LEFT, fill=X)
		ent_lab = Label(form, text="Your guess: ", width=10)
		ent_lab.pack(side=LEFT)
		var = IntVar()
		ent = Entry(form, textvariable=var, width=3)
		ent.pack(side=LEFT)	

		# creates button to check the guess/ enter game loop
		but = Button(self, text="Check", width=5, height=3, command=(lambda: self.turn(var.get())))
		but.pack(side=RIGHT, fill=X, expand=YES)

	def counter(self):
		"keeps track of the number of guesses"
		self.count += 1
		return self.count

	def turn(self, num):	
		"gameloop to guess a number 1 to 10 in 3 tries"
		# count the guesses
		total = self.counter() 
		# if num == my_number:
		if num == self.my_number:
			# create a window for win
			pop_win = Toplevel()
			labl = Label(pop_win, text='You win! :)', width=20, height=10)
			labl.pack(expand=YES, fill=BOTH)
		elif total == 3:
			pop_loss = Toplevel()
			llbl = Label(pop_loss, text='You lose! :(', width=20, height=10)
			llbl.pack(expand=YES, fill=BOTH)
		else:
			if num > self.my_number:
				less = Label(self, text='Guess lower!', width=20)
				less.pack(side=LEFT)
			else:
				more = Label(self, text='Guess higher!', width=20)
				more.pack(side=LEFT)

if __name__ == '__main__':
	root = Tk()
	root.title('Guess My Number!')
	gn = GuessMyNumber(root)
	gn.pack(side=TOP)
	root.mainloop()
