from django.urls import path
from . import views

app_name = 'djtestapp'
urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
] 