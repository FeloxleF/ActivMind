from django.contrib import admin

from core.models import CustomUser, UserInfo

# Register your models here.


# Register CustomUser and UserInfo models
admin.site.register(UserInfo)

