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


class UserInfo(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)

    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    address_number = models.IntegerField(null=True)
    address_street = models.CharField(max_length=100, blank=True)
    address_city = models.CharField(max_length=100, blank=True)
    address_postal_code = models.CharField(max_length=100, blank=True)
    address_country = models.CharField(max_length=100, blank=True)
    phone_number = models.CharField(max_length=100, blank=True)

    def __str__(self):
        return f"{self.user.email}'s info"
    
    def update_first_name(self, new_first_name):
        self.first_name = new_first_name
        self.save()
        
    def update_last_name(self, new_last_name):
        self.last_name = new_last_name
        self.save()

    def update_date_of_birth(self, new_date_of_birth):
        self.date_of_birth = new_date_of_birth
        self.save()

    def update_address_number(self, new_address_number):
        self.address_number = new_address_number
        self.save()

    def update_address_street(self, new_address_street):
        self.address_street = new_address_street
        self.save()


