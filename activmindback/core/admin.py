from django.contrib import admin
from rest_framework.authtoken.models import Token

class TokenAdmin(admin.ModelAdmin):
    search_fields = ['token']  # Ajoutez les champs que vous souhaitez utiliser pour la recherche


