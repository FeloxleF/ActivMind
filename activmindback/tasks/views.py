from django.shortcuts import render
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from core.models import Task
from .serializers import TaskSerializer, CreateTaskSerializer
from rest_framework.authentication import SessionAuthentication, BasicAuthentication

from datetime import datetime


class TasksViewSet(ModelViewSet):
    date = datetime.now()
    http_method_names = ['get', 'post', 'put', 'patch', 'delete']
    authentication_classes = [SessionAuthentication, BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        serializer = CreateTaskSerializer(
            data=request.data,
            context={'user_id':self.request.user.id}
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    def update(self, request, *args, **kwargs):
        return super().update(request, *args, **kwargs)

    def get_queryset(self):
        query = Task.objects.filter(user_id=self.request.user.id).order_by('do_date','start_time')
        return query

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return CreateTaskSerializer
        else:
            return TaskSerializer

