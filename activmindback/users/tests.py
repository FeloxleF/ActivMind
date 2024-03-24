from django.test import TestCase
from rest_framework.authtoken.models import Token
# Create your tests here.

from django.test import TestCase
from rest_framework.test import APIClient
from rest_framework import status
from users.serializers import UserSerializer
from users.data_structures.user_structures import Adresse
from core.models import CustomUser as User
from core.models import UserInfo

class CreateUserTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(email='test1@example.com', password='password1234')
        
    def test_first(self):
        self.assertEqual(1, 1)
        
    def test_create_user(self):
    # Pour l'instant on ne teste que la création d'un utilisateur pas du user_info
        user_data = {
            'email': 'test@example.com',
            'password': 'password123',
            'user_type': 'A',
            'first_name': 'John',
            'last_name': 'Doe',
            'date_of_birth': '1990-01-01',
            # Autres champs requis pour la création de l'utilisateur...
        }

        # Envoyer une requête POST pour créer un nouvel utilisateur
        response = self.client.post('/register/', user_data, format='json')

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        user = User.objects.get(email='test@example.com')
        
        self.assertIsNotNone(user)
        self.assertEqual(response.data['email'], user.email)            
        self.assertTrue(user.check_password('password123'))
        self.assertEqual(user.user_type, 'A')
        self.assertEqual(user.user_info.first_name, 'John')
        self.assertEqual(user.user_info.last_name , 'Doe')
        self.assertEqual(str(user.user_info.date_of_birth), '1990-01-01')
        # TODO: Add more assertions to test additional fields in user_info
        

    def test_login(self):
        url = '/auth/login/'
        data = {'email': 'test1@example.com', 'password': 'password1234'}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('token', response.data)

    def test_logout(self):
        # Login the user first
        self.client.login(username='test1@example.com', password='password1234')
        url = '/auth/logout/'
        response = self.client.post(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['message'], 'Logged out successfully')
        
    def test_check_token_authenticated(self):
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.user.auth_token.key)
        response = self.client.get('/check_token/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, {'message': 'Token is valid'})

    def test_check_token_unauthenticated(self):
        response = self.client.get('/check_token/')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
    
    def test_adresse_creation(self):
        adresse = Adresse(123, "Main St", "City", "12345")
        self.assertEqual(adresse.number, 123)
        self.assertEqual(adresse.street, "Main St")
        self.assertEqual(adresse.city, "City")
        self.assertEqual(adresse.postal_code, "12345")
        
    