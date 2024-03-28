from django.urls import path
from rest_framework_nested import routers
# from .views import register_user, login_user, update_password, RegisterUser
from .views import  AssociateUserViewSet, RegisterUserViewSet, AuthViewSet, check_token


router = routers.DefaultRouter()
router.register('register', RegisterUserViewSet, basename='register')
router.register(r'auth', AuthViewSet, basename='auth')
router.register(r'associate', AssociateUserViewSet, basename='associate')



urlpatterns = router.urls
urlpatterns = urlpatterns + [
    path('check_token/', check_token, name='check_token'),
]   
