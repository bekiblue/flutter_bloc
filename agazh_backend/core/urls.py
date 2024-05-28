from django.urls import path
from . import views


app_name = 'core'

urlpatterns = [
path('job/', views.Job.as_view(), name='job'),
path('user/', views.User.as_view(), name='User'),
path('signup/', views.SignUp.as_view(), name='signup'),
path('user/<int:pk>/',views.User.as_view(), name='get_a_user'),
path('application/', views.Application.as_view(), name='application'),
path('me/', views.me, name='me'),
]