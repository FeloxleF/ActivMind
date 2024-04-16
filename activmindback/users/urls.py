from django.urls import path
from rest_framework_nested import routers
# from .views import register_user, login_user, update_password, RegisterUser
from .views import  AssociateUserViewSet, RegisterUserViewSet, AuthViewSet, check_token, get_csrf_token, forgot_password, reset_password


router = routers.DefaultRouter()
router.register('register', RegisterUserViewSet, basename='register')
router.register(r'auth', AuthViewSet, basename='auth')
router.register(r'associate', AssociateUserViewSet, basename='associate')



urlpatterns = router.urls
urlpatterns = urlpatterns + [
    path('check_token/', check_token, name='check_token'),
    path('csrf_token/', get_csrf_token, name='csrf_token'),
    path('forgot_password/', forgot_password, name='forgot_password'),
    path('reset_password/', reset_password, name='reset_password'),
    # path('reset_password/', ResetPasswordView.as_view(), name='reset_password'),
    


]   
