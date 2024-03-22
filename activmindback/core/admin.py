from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser

class CustomUserAdmin(UserAdmin):
    # Définissez les champs que vous souhaitez afficher dans l'administration Django
    list_display = ('email', 'user_type', 'is_active', 'is_staff','date_joined')
    search_fields = ('email',)  # Définissez les champs que vous souhaitez utiliser pour la recherche
    ordering = ('date_joined',)  # Définissez les champs que vous souhaitez utiliser pour le tri
    
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Personal Info', {'fields': ('user_type',)}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser')}),
        ('Important dates', {'fields': ('last_login',)}),
        ('Associated users', {'fields': ('associated_user',)}),
    )
    
# Enregistrez le modèle CustomUser avec CustomUserAdmin
admin.site.register(CustomUser, CustomUserAdmin)



