from rest_framework.serializers import ModelSerializer
from core.models import Location

class LocationSerializer(ModelSerializer):
    class Meta:
        model = Location
        fields = ['id','latitude', 'longitude', 'location_name']
    
    def save(self, **kwargs):
        Location.objects.create(user_id= self.context['user_id'], **self.validated_data)

