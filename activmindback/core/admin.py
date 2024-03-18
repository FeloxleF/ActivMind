from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser

class CustomUserAdmin(UserAdmin):
    # Définissez les champs que vous souhaitez afficher dans l'administration Django
    list_display = ('email', 'user_type', 'is_active', 'is_staff', 'date_joined')
    search_fields = ('email',)  # Définissez les champs que vous souhaitez utiliser pour la recherche

# Enregistrez le modèle CustomUser avec CustomUserAdmin
admin.site.register(CustomUser, CustomUserAdmin)



