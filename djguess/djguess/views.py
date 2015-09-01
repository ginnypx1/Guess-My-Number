from django.shortcuts import render


def index(request):
	return render(request, 'title_page.html')