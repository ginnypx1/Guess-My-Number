from django.shortcuts import render

# Create your views here.
def guessing_game(request):
	return render(request, 'guess_my_number/game.html')