from django.urls import path
from rest_framework_nested import routers
# from .views import register_user, login_user, update_password, RegisterUser
from .views import TaskAssociatedUserViewSet, TasksViewSet

router = routers.DefaultRouter()
router.register('tasks', TasksViewSet, basename='tasks')
router.register('tasks_associated_user', TaskAssociatedUserViewSet, basename='asso')




urlpatterns = router.urls