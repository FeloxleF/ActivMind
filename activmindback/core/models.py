from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _
from django.db.models.signals import post_save
from rest_framework.authtoken.models import Token
import re
from django.conf import settings    

from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser, PermissionsMixin
from django.conf import settings
import re
from activmindback.core.serializers import UserInfoSerializer

from activmindback.users.models import UserInfo



class CustomUserManager(BaseUserManager):
    
    def create_user(self, email, password, first_name, last_name, date_of_birth, **extra_fields):
        
        # etape 1: verification des données pour le User et creation du User
        if not email:
            raise ValueError("user must have an email")
        
        if not password:
            raise ValueError("user must have a password")
        
        if self.is_valid_password(password):
            self.password = password
        else:
            raise ValueError("Invalid password format")     
        
        if self.is_valid_email(email):
            email = self.normalize_email(email)
        else:
            raise ValueError("Invalid email format") 
    
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        
        # etape 2 : verification du UserInfo et creation du UserInfo
        user_info_data = {
            'user': user,
            'first_name': first_name,
            'last_name': last_name,
            'date_of_birth': date_of_birth,
            **extra_fields
        }
        
        user_info_serializer = UserInfoSerializer(data=user_info_data)
        if user_info_serializer.is_valid():
            user_info_serializer.save()
        else:
            raise ValueError("Invalid user info data")
        
        
        
        return user
    
    
    
    def is_valid_password(self, password):
            regex = r"^[^\s]{8,}$"
            password_regex = re.compile(regex)
            return re.match(password_regex, password) is not None
    
    def is_valid_email(self, email):
        regex = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
        email_regex = re.compile(regex)
        return re.match(email_regex, email) is not None

    def create_superuser(self,email,password,**extra_fields):
         user = self.create_user(email=email,password=password,**extra_fields)
         user.is_staff = True
         user.is_superuser = True
         user.save(using=self._db)
         
         return user

class CustomUser(AbstractBaseUser, PermissionsMixin):

    email = models.EmailField(_('email address'), unique=True, max_length=100)
    type = models.IntegerField(null=True, blank=True)
    is_active = models.BooleanField(_('active'), default=True)
    is_staff = models.BooleanField(_('staff status'), default=False)
    date_joined = models.DateTimeField(_('date joined'), auto_now_add=True)

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')

    def __str__(self):
        return self.email
    
@receiver(post_save, sender=CustomUser)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
