from django.urls import path
from rest_framework_nested import routers
# from .views import register_user, login_user, update_password, RegisterUser
from .views import  TasksViewSet

router = routers.DefaultRouter()
router.register('', TasksViewSet, basename='tasks')



urlpatterns = router.urls