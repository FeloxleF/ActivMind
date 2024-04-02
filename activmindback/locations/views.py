from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status

from .serializers import LocationSerializer
from core.models import Location

# Create your views here.
class LocationsViewSet(ModelViewSet):
    http_method_names = ['get', 'post', 'put', 'patch', 'delete']
    permission_classes = [IsAuthenticated]
    serializer_class = LocationSerializer
    
    def get_queryset(self):
        return Location.objects.filter(user=self.request.user)
    
    def create(self, request, *args, **kwargs):
        print(self.request.data)
     

        # on ajoute task_user_id dans le body de la requête pour pouvoir créer une tâche pour un autre utilisateur
        
        user_id = self.request.user.id
        print(user_id)
        serializer = LocationSerializer(
            data=request.data,
            context={'user_id':user_id}
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)