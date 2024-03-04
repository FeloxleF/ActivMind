from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _
from django.db.models.signals import post_save
from rest_framework.authtoken.models import Token
from django.core.validators import MaxValueValidator

class CustomUserManager(BaseUserManager):
    
    def create_user(self, email, password, **extra_fields):
        # fonction par defaut peu securisée, utiliser celle de UserManagementService
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self,email,password,**extra_fields):
         user = self.create_user(email=email,password=password,**extra_fields)
         user.is_staff = True
         user.is_superuser = True
         user.save(using=self._db)
         
         return user

class CustomUser(AbstractBaseUser, PermissionsMixin):

    email = models.EmailField(_('email address'), unique=True, max_length=100)
    type = models.IntegerField(null=True, validators=[MaxValueValidator(2)])
    # les types de user sont 0 = patient, 1 = proche, 2 = assistant
    
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
