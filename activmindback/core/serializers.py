from rest_framework import serializers
from django.contrib.auth import get_user_model
# from users.models import UserInfo  # Importation tardive pour éviter la dépendance circulaire

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('email', 'password', 'type') 
        extra_kwargs = {'password': {'write_only': True}}

class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        fields = '__all__'
        
