from rest_framework.serializers import ModelSerializer
from core.models import Location

class LocationSerializer(ModelSerializer):
    class Meta:
        model = Location
        fields = ['latitude', 'longitude', 'location_name', 'user']

