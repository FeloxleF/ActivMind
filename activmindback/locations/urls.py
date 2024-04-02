from django.urls import path
from rest_framework_nested import routers
# from .views import register_user, login_user, update_password, RegisterUser
from .views import LocationsViewSet

router = routers.DefaultRouter()
router.register('', LocationsViewSet, basename='locations')




urlpatterns = router.urls