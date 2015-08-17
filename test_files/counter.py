from tkinter import *
import sys

root = Tk()
root.title('Counter Button')

counter = IntVar()

def Count():
	counter.set(counter.get() + 1)
	print(counter.get())

Label(root, textvariable=counter).pack()
Button(root, text="Increase", command=Count).pack()

root.mainloop()