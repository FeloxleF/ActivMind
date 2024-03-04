import re
from core.serializers import UserInfoSerializer, UserSerializer
from django.contrib.auth.hashers import make_password
# Service qui s'occuppe de l'enregistrement des données utilisateurs en base
class UserManagementService:

    # creation d'un utilisateur et UserInfo de manière sécurisée
    
    def create_user(self, user_data):
        
        # recuperation des données
        email = user_data.get('email')
        password = user_data.get('password')
        account_type = user_data.get('type')
        first_name = user_data.get('first_name')
        last_name = user_data.get('last_name')
        date_of_birth = user_data.get('date_of_birth')
        address_number = user_data.get('address_number')
        address_street = user_data.get('address_street')
        address_city = user_data.get('address_city')
        address_postal_code = user_data.get('address_postal_code')
        address_country = user_data.get('address_country')
        phone_number = user_data.get('phone_number')   
        
        print(email, password, account_type)
        # verification des données obligatoires
        if not email or not password or not account_type or not first_name or not last_name or not date_of_birth:
            raise ValueError("Missing required fields")
        
        # verification des données pour le User
        if not self.is_valid_email(email):
            raise ValueError("Invalid email")
        
        if not self.is_valid_password(password):
            raise ValueError("Invalid password")
        
        user_serializer = UserSerializer(data={'email': email, 'password': make_password(password), 'type': account_type})
        
        # validation et creation d'un User et UserInfo
        if user_serializer.is_valid():
            user = user_serializer.save()
            
            # creation data pour UserInfo
            user_info_data = {
                'user': user.id,
                'first_name': first_name,
                'last_name': last_name,
                'date_of_birth': date_of_birth,
                'address_number': address_number,
                'address_street': address_street,
                'address_city': address_city,
                'address_postal_code': address_postal_code,
                'address_country': address_country,
                'phone_number': phone_number
            }
            user_info_serializer = UserInfoSerializer(data=user_info_data)
            
            if user_info_serializer.is_valid():
                user_info_serializer.save()
            else: raise ValueError(user_info_serializer.errors)
        else: raise ValueError(user_serializer.errors)
        
        return user
    
    def is_valid_password(self, password):
        regex = r"^[^\s]{8,}$"
        password_regex = re.compile(regex)
        return re.match(password_regex, password) is not None
    
    def is_valid_email(self, email):
        regex = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
        email_regex = re.compile(regex)
        return re.match(email_regex, email) is not None