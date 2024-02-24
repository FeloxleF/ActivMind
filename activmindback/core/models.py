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


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password= None, **extra_fields):
        """ctreat and save new user"""
        if not email:
            raise ValueError("user must have an email")

        if self.is_valid_password(password):
            self.password = password
        else:
            raise ValueError("Invalid password format")      
    
        user = self.model(email=self.normalize_email(email), **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def is_valid_password(self, password):
            
         
            # min_length = 8
            # regex = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])(?=.*\d)[A-Za-z\d@$!%*?&]{" + str(int(min_length)) + r",}$"
            regex = r"^[^\s]{8,}$"
            password_regex = re.compile(regex)

            return re.match(password_regex, password) is not None

    def create_superuser(self,email,password,**extra_fields):
         user = self.create_user(email=email,password=password,**extra_fields)
         user.is_staff = True
         user.is_superuser = True
         user.save(using=self._db)
         
         return user

class CustomUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(_('email address'), unique=True)
    type = models.IntegerField(null=True, blank=True )
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
