from django.contrib import admin

from core.models import Task, Sport, Activity, Medicament   

# Register your models here.


# Register Task, Sport, Activity, and Medicament models
admin.site.register(Task)
admin.site.register(Sport)
admin.site.register(Activity)
admin.site.register(Medicament)