from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated

from .serializers import LocationSerializer
from core.models import Location

# Create your views here.
class LocationsViewSet(ModelViewSet):
    http_method_names = ['get', 'post', 'put', 'patch', 'delete']
    permission_classes = [IsAuthenticated]
    serializer_class = LocationSerializer
    def get_queryset(self):
        return Location.objects.filter(user=self.request.user)