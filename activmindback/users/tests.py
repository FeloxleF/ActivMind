from django.test import TestCase
# Create your tests here.

from django.test import TestCase
from rest_framework.test import APIClient
from rest_framework import status
from core.models import CustomUser as User

class CreateUserTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        
        
    def test_first(self):
        self.assertEqual(1, 1)
        
    # def test_create_user(self):
    # # Pour l'instant on ne teste que la création d'un utilisateur pas du user_info
    #     user_data = {
    #         'email': 'test@example.com',
    #         'password': 'password123',
    #         'user_type': 'A',
    #         # Autres champs requis pour la création de l'utilisateur...
    #     }

    #     # Envoyer une requête POST pour créer un nouvel utilisateur
    #     response = self.client.post('/register/', user_data, format='json')

    #     # Vérifier si la requête a abouti avec le code de statut HTTP 201 (Créé)
    #     self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    #     # Vérifier si l'utilisateur est correctement enregistré dans la base de données
    #     user = User.objects.get(email='test@example.com')
    #     self.assertIsNotNone(user)

    #     # Vérifier si les données renvoyées correspondent aux données envoyées
    #     self.assertEqual(response.data['email'], user.email)
    #     # Vérifier d'autres champs si nécessaire...
        
    #     # Vérifier si le mot de passe est correctement hashé
    #     self.assertNotEqual(response.data['password'], 'password123')
    #     self.assertTrue(user.check_password('password123'))

