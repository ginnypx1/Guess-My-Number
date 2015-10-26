import random

from flask import Flask, flash, redirect, render_template, session, url_for

from flask.ext.bootstrap import Bootstrap
from flask.ext.wtf import Form 

from wtforms import IntegerField, SubmitField
from wtforms.validators import NumberRange

# creates app and a secret key
app = Flask(__name__)
app.config['SECRET_KEY'] = 'fdjkahgiuengkjndfsjkbruifajsbjkfdbiugehfjkarsdjkvbv'

# applies bootstrap styling
bootstrap = Bootstrap(app)

# creates a form for the number guess
class GuessForm(Form):
	guess = IntegerField('Pick a number 1-10:', validators=[NumberRange(message="Between 1 and 10 please.", min=1, max=10)])

# index route displays game
@app.route('/', methods=['GET', 'POST'])
def index():
	form = GuessForm()
	return render_template('game.html', form=form, guess=session.get('guess'))


if __name__ == '__main__':
	app.run(debug=True)