from django.contrib import admin

from core.models import CustomUser, UserInfo, Task, Sport, Activity, Medicament

# Register your models here.


# Register CustomUser and UserInfo models
admin.site.register(CustomUser)
admin.site.register(UserInfo)

