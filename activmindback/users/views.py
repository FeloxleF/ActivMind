from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated
from django.contrib.auth import authenticate, login
# from django.contrib.auth.tokens import default_token_generatorpipenv
# from django.contrib.auth.models import User
from django.views import View
from django.http import JsonResponse
from django.middleware.csrf import get_token
from django.core.mail import send_mail
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt

# from activmindback.core.services import UserManagementService
from .serializers import UserSerializer
from core.models import CustomUser as User

# def get_csrf_token(request):
#     csrf_token = get_token(request)
#     return JsonResponse({'csrf_token': csrf_token})


# @api_view(['POST'])
# def register_user(request):
#     if request.method == 'POST':
#         serializer = UserSerializer(data=request.data)
#         if serializer.is_valid():
#             try:
#                 user = serializer.save()
#                 token, _ = Token.objects.get_or_create(user=user)
#                 return Response({'token': token.key}, status=status.HTTP_201_CREATED)
#             except Exception as e:
#                 if 'password' in serializer.errors:
#                     # Handle the case where the password format is invalid
#                     error_message = "Invalid password format: " + ", ".join(serializer.errors['password'])
#                     return Response({'error': error_message}, status=status.HTTP_400_BAD_REQUEST)
#                 else:
#                     # Handle other exceptions
#                     return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
#         else:
#             return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        

class RegisterUser(APIView):
    queryst = User.objects.all()
    serializer_class = UserSerializer
    # def get_permissions(self):
    #     if self.request.method == 'POST':
    #         return [AllowAny()]
    #     else:
    #         return[IsAuthenticated()]



# @api_view(['POST'])
# def login_user(request):
#     if request.method == 'POST':
#         email = request.data.get('email')
#         password = request.data.get('password')
#         user = authenticate(email=email, password=password)
#         if user:
#             login(request, user)
#             token, _ = Token.objects.get_or_create(user=user)
#             return Response({'token': token.key}, status=status.HTTP_200_OK)
#         return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
    

# class ForgotPasswordView(View):
#     def post(self, request):
#         email = request.POST.get('email')
#         user = User.objects.filter(email=email).first()
#         if user:
#             token = default_token_generator.make_token(user)
#             reset_link = f"{settings.BASE_URL}/reset-password/{token}/"
#             send_mail(
#                 'Password Reset',
#                 f'Click this link to reset your password: {reset_link}',
#                 settings.EMAIL_HOST_USER,
#                 [email],
#                 fail_silently=False,
#             )
#             return JsonResponse({'message': 'Password reset link sent successfully'})
#         else:
#             return JsonResponse({'error': 'No user found with this email'}, status=400)

# @csrf_exempt
# class ResetPasswordView(View):
#     def get(self, request, token):
#         # Verify token and render password reset form
#         return JsonResponse({'message': 'Password reset form'})

#     def post(self, request, token):
#         # Reset password
#         return JsonResponse({'message': 'Password reset successfully'})
    

# @api_view(['PUT'])
# def update_password(request):
#     if request.method == 'PUT':
#         email = request.data.get('email')
#         try:
#             user = User.objects.get(email=email)
#         except user.DoesNotExist:
#             return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
#         user_management_service = UserManagementService()
#         try:
#             user_management_service.reinit_password(user, request.data.get('password'))
#             logger.info(f"User {user.email} has updated his password")
#             return Response(status=status.HTTP_200_OK)
#         except Exception as e:
#             return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)  
        


