from django.core.urlresolvers import reverse
from django.test import TestCase

# Create your tests here.
class ViewTest(TestCase):
	def test_game_view(self):
		resp = self.client.get(reverse('guessinggame:game'))
		self.assertEqual(resp.status_code, 200)
		self.assertTemplateUsed(resp, 'guess_my_number/game.html')
