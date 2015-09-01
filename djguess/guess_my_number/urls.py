from django.conf.urls import url

from . import views

urlpatterns = [
	url(r'^$', views.guessing_game, name='game'),
]