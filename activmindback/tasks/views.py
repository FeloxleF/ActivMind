from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from core.models import Task
from .serializers import TaskSerializer, CreateTaskSerializer

from datetime import datetime


class TasksViewSet(ModelViewSet):
    date = datetime.now()
    http_method_names = ['get', 'post', 'put', 'patch', 'delete']
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        serializer = CreateTaskSerializer(
            data=request.data,
            context={'user_id':self.request.user.id}
        )
        serializer.is_valid(raise_exception=True)
        task=serializer.save()
        # serializer= TaskSerializer(task)
        return Response(serializer.data)

    def get_queryset(self):
        return Task.objects.filter(user_id=self.request.user.id).order_by('do_date','start_time')

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return CreateTaskSerializer
        else:
            return TaskSerializer

