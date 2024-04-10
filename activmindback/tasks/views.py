import logging
from django.shortcuts import render
from django.core.exceptions import PermissionDenied
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework import status
from core.models import CustomUser, Sport, Task
from .serializers import SportSerializer, TaskSerializer, CreateTaskSerializer
from rest_framework.authentication import SessionAuthentication, BasicAuthentication

from datetime import datetime

class TasksViewSet(ModelViewSet):
    date = datetime.now()
    http_method_names = ['get', 'post', 'put', 'patch', 'delete']
    # authentication_classes = [SessionAuthentication, BasicAuthentication] 
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        # on ajoute task_user_id dans le body de la requête pour pouvoir créer une tâche pour un autre utilisateur
        associated_user_id = self.request.data.get('task_user_id')
        print(request.data)
        if associated_user_id and self.is_associated_user(int(associated_user_id)):
            user_id = int(associated_user_id)
        else:
            user_id = self.request.user.id
            
        serializer = CreateTaskSerializer(
            data=request.data,
            context={'user_id':user_id}
        )
        
        if serializer.is_valid(raise_exception=True):
            serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    def get_queryset(self):
        date_param = self.request.query_params.get('date')
        associated_user_id = int(self.request.query_params.get('task_user_id')) if self.request.query_params.get('task_user_id') else None
        
        if date_param and associated_user_id:
            date = datetime.strptime(date_param, '%Y-%m-%d')
            if self.is_associated_user(associated_user_id):
                query = Task.objects.filter(user_id=associated_user_id, do_date=date).order_by('start_time')
            else: 
                raise PermissionDenied('Cet utilisateur n\'est pas associé à votre compte')
            
        elif date_param:
            date = datetime.strptime(date_param, '%Y-%m-%d')
            query = Task.objects.filter(user_id=self.request.user.id, do_date=date).order_by('start_time')
            
        elif associated_user_id:
            if self.is_associated_user(associated_user_id):
                query = Task.objects.filter(user_id=associated_user_id).order_by('do_date', 'start_time')
            else: 
                raise PermissionDenied('Cet utilisateur n\'est pas associé à votre compte')
            
        else:
            query = Task.objects.filter(user_id=self.request.user.id).order_by('do_date', 'start_time')
        return query
    # TODO: faire les test de ce qui est au dessus

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return CreateTaskSerializer
        else:
            return TaskSerializer

    def is_associated_user(self, user_id):
        user = CustomUser.objects.get(id=self.request.user.id)
        associated_users = user.associated_user.all()
        associated_user_ids = [au.id for au in associated_users]
        if user_id in associated_user_ids:
            return True
        else:
            return False