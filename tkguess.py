from tkinter import *
import random

root = Tk()
root.title('Guess My Number!')

# game variables
my_number = random.randint(1, 10)

# create game directions
lab = Label(text="I am thinking of a number 1 to 10...", width=40, height=1)
labl = Label(text="Try to guess it in 3 tries!", width=40, height=1)
lab.pack(side=TOP, fill=BOTH)
labl.pack(side=TOP, fill=BOTH)

# create an entry for for your guess
form = Frame(root)
form.pack(side=LEFT, fill=X)

ent_lab = Label(form, text="Your guess: ", width=10)
ent_lab.pack(side=LEFT)

var = IntVar()
ent = Entry(form, textvariable=var, width=3)
ent.pack(side=LEFT)	

# function to keep track of guesses
counter = IntVar()

def count():
	counter.set(counter.get() + 1)
	return counter.get()

# function to check the guess
def turn():	
	# count the guesses
	total = count() 
	# keep track of your guess
	num = var.get()
	# if num == my_number:
	if num == my_number:
		# create a window for win
		pop_win = Toplevel()
		labl = Label(pop_win, text='You win! :)', width=20, height=10)
		labl.pack(expand=YES, fill=BOTH)
	elif total == 3:
		pop_loss = Toplevel()
		llbl = Label(pop_loss, text='You lose! :(', width=20, height=10)
		llbl.pack(expand=YES, fill=BOTH)
	else:
		if num > my_number:
			less = Label(root, text='Guess lower!', width=20)
			less.pack(side=LEFT)
		else:
			more = Label(root, text='Guess higher!', width=20)
			more.pack(side=LEFT)

# creates button to check the guess/ enter game loop
but = Button(root, text="Check", width=5, height=3, command=turn)
but.pack(side=RIGHT, fill=X, expand=YES)

root.mainloop()