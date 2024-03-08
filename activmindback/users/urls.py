from django.urls import path
from rest_framework_nested import routers
# from .views import register_user, login_user, update_password, RegisterUser
from .views import  RegisterUserViewSet, AuthViewSet

router = routers.DefaultRouter()
router.register('register', RegisterUserViewSet, basename='register')
router.register(r'auth', AuthViewSet, basename='auth')



urlpatterns = router.urls
# urlpatterns = [
#     # path('register/', register_user, name='register'),
#     path('register/', RegisterUser.as_view()),
#     # path('login/', login_user, name='login'),
#     # path('updatepwd/', update_password, name='update-password'),
# ]   
