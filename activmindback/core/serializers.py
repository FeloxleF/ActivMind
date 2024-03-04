from rest_framework import serializers
from django.contrib.auth import get_user_model
from core.models import CustomUser
from users.models import UserInfo

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('email', 'password', 'type') 
        extra_kwargs = {'password': {'write_only': True}}

class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserInfo
        fields = '__all__'
        
