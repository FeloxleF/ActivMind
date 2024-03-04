from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate, login
from core.models import CustomUser
from core.services import UserManagementService
import logging

logger = logging.getLogger(__name__)


# cette methode enregistre toutes les infos sur l'utilisateur donc il faudra que le front envoie une seule requete une 
# fois le formulaire rempli
@api_view(['POST'])
def register_user(request):
    if request.method == 'POST':
        try:
            user_management_service = UserManagementService()
            user = user_management_service.create_user(user_data=request.data)
            token, _ = Token.objects.get_or_create(user=user)
            logger.info(f"User {user.email} has been created")
            return Response({'token': token.key}, status=status.HTTP_201_CREATED)
        except Exception as e:
            # Handle exceptions
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def login_user(request):
    if request.method == 'POST':
        email = request.data.get('email')
        password = request.data.get('password')
        user = authenticate(email=email, password=password)
        if user:
            login(request, user)
            token, _ = Token.objects.get_or_create(user=user)
            return Response({'token': token.key}, status=status.HTTP_200_OK)
        return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['PUT'])
def update_password(request):
    if request.method == 'PUT':
        email = request.data.get('email')
        try:
            user = CustomUser.objects.get(email=email)
        except CustomUser.DoesNotExist:
            return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
        user_management_service = UserManagementService()
        try:
            user_management_service.reinit_password(user, request.data.get('password'))
            logger.info(f"User {user.email} has updated his password")
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)  
        
    
    
    