from django.urls import path
from rest_framework_nested import routers
from .views import LocationsViewSet

router = routers.DefaultRouter()
router.register('', LocationsViewSet, basename='locations')

urlpatterns = router.urls