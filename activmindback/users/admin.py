from django.contrib import admin

from core.models import CustomUser, UserInfo, Task, Sport, Activity, Medicament

# Register your models here.


# Register CustomUser and UserInfo models
admin.site.register(CustomUser)
admin.site.register(UserInfo)

# Register Task, Sport, Activity, and Medicament models
admin.site.register(Task)
admin.site.register(Sport)
admin.site.register(Activity)
admin.site.register(Medicament)