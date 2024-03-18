import json
from django.test import TestCase

from rest_framework.test import APITestCase
from rest_framework.authtoken.models import Token
from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from tasks.serializers import TaskSerializer
from core.models import Task, UserInfo

User = get_user_model()

class TasksViewSetTestCase(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(email='test2@example.com', password='password12345', user_type='P')
        self.user_info = UserInfo.objects.create(user=self.user, first_name='John', last_name='Doe', date_of_birth='1990-01-01')
        # self.client.force_login(self.user)
        self.task = Task.objects.create(user_id=self.user.id, title='Test Task 1', discription='Test Description 1', do_date='2024-03-22', start_time='10:00:00', end_time='12:00:00', repetation=False, alarm=True)
        print(" prems le id est" + str(self.task.id))
        
    # on test la creation d'une tache car on a redéfini la méthode create dans la view
    def test_create_task(self):
        url = '/tasks/'
        data = {
            'title': 'Test Task',
            'discription': 'Test Description',
            'do_date': '2024-03-21',
            'start_time': '10:00:00',
            'end_time': '12:00:00',
            'repetation': False,
            'alarm': True
        }
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Task.objects.count(), 2)
        task = Task.objects.get(user=self.user, title='Test Task')
        self.assertEqual(task.title, 'Test Task')
        self.assertEqual(task.discription, 'Test Description')
        # self.assertEqual(task.do_date.strftime('%Y-%m-%d'), '2024-03-21')
        self.assertEqual(task.start_time.strftime('%H:%M:%S'), '10:00:00')
        self.assertEqual(task.end_time.strftime('%H:%M:%S'), '12:00:00')
        self.assertFalse(task.repetation)
        self.assertTrue(task.alarm)
        
        
    
    # on test la methode put pour etre sur que la modification d'une tache fais par le framework (class ModelViewSet) fonctionne
    # Les autres methodes : GET, DELETE, PATCH sont testées par le framework aussi on considere que c'est ok 
    def test_update_task(self):
        
        print("le id est" + str(self.task.id))
        
        url = '/tasks/' + str(self.task.id) + '/'
        updated_data = {
            'title': 'Updated Task',
            'discription': 'Updated Description',
            'do_date': '2024-03-21',
            'start_time': '12:00:00',
            'end_time': '14:00:00',
            'repetation': True,
            'alarm': False
        }
        response = self.client.put(url, updated_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        response_data = response.json()
        
        task = Task.objects.get(id=response_data['id'])
        self.assertEqual(task.title, updated_data['title'])
        self.assertEqual(task.discription, updated_data['discription'])
        self.assertEqual(task.do_date.strftime('%Y-%m-%d'), updated_data['do_date'])
        self.assertEqual(task.start_time.strftime('%H:%M:%S'), updated_data['start_time'])
        self.assertEqual(task.end_time.strftime('%H:%M:%S'), updated_data['end_time'])
        self.assertEqual(task.repetation, updated_data['repetation'])
        self.assertEqual(task.alarm, updated_data['alarm'])