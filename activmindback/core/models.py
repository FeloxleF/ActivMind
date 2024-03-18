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
        #min_length = 8
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

    PATIENT = 'P'
    SUPPORT = 'S'
    ASSITANT = 'A'
    type_choise = [
       (PATIENT, 'patient'),
       (SUPPORT, 'support'),
       (ASSITANT, 'assistent')
    ]
    email = models.EmailField(_('email address'),max_length=100, unique=True)
    is_active = models.BooleanField(_('active'), default=True)
    is_staff = models.BooleanField(_('staff status'), default=False)
    date_joined = models.DateTimeField(_('date joined'), auto_now_add=True)
    user_type = models.CharField(max_length=1, choices= type_choise, default=PATIENT)

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    
    @property
    def user_info(self):
        return self.userinfo_set.first()

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
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE, unique=True, related_name='user_info')

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


class Task(models.Model):
    title = models.CharField(max_length=100)
    discription = models.CharField(max_length=200)
    creation_date = models.DateTimeField(auto_now_add=True)
    do_date = models.DateField()
    start_time = models.TimeField()
    end_time = models.TimeField(null=True, blank=True)
    repetation = models.BooleanField(default=False)
    alarm = models.BooleanField(default= False)
    done = models.BooleanField(default= False)
    user = models.ForeignKey(CustomUser, on_delete= models.CASCADE, related_name='user_id')
    

class Sport(models.Model):
    Sporttype = models.CharField(max_length=20)
    repeatation_number = models.IntegerField()
    info = models.CharField(max_length=100)
    task= models.ForeignKey(Task,on_delete=models.CASCADE, related_name='task_id')


class Activity(models.Model):
    location = models.CharField(max_length=50)
    text = models.CharField(max_length=100)
    task= models.ForeignKey(Task,on_delete=models.CASCADE)


class Medicament(models.Model):
    dosage = models.CharField(max_length=100)
    infosupport = models.CharField(max_length=100)


