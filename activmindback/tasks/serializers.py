from rest_framework import serializers
from django.contrib.auth import get_user_model
from core.models import Task

class TaskSerializer(serializers.ModelSerializer):

    class Meta:
        model = Task
        fields=('title','discription','do_date', 'start_time','end_time' , 'alarm' , 'repetation','done','id' ,'user_id')

class CreateTaskSerializer(serializers.Serializer):

    title = serializers.CharField(max_length=100)
    discription = serializers.CharField(max_length=200)
    do_date = serializers.DateField()
    start_time = serializers.TimeField()
    end_time = serializers.TimeField()
    repetation = serializers.BooleanField()
    alarm = serializers.BooleanField()
    

    def save(self, **kwargs):
        task = Task.objects.create(user_id= self.context['user_id'], **self.validated_data)
