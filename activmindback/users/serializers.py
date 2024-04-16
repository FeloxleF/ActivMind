from rest_framework import serializers
from django.contrib.auth import get_user_model
from core.models import CustomUser
from core.models import UserInfo



class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ('email', 'password', 'user_type') 
        extra_kwargs = {'password': {'write_only': True}}
        
    def create(self,validate_data):
        """create new user"""
        return get_user_model().objects.create_user(**validate_data)
    
    def update(self, instance, validated_data):
        """update user profile"""
        password = validated_data.pop('password', None)
        user = super().update(instance, validated_data)

        if password:
            user.set_password(password)
            user.save()
        return user
    
class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserInfo
        fields = (
                'first_name',
                'last_name',
                'date_of_birth',
                'address_number',
                'address_street',
                'address_city', 
                'address_postal_code', 
                'address_country', 
                'phone_number'
                )
        
