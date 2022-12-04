from django.urls import path
from . import views
urlpatterns = [
    path(
        'peliculas/', views.PeliculasApi.as_view()
    ),
    path(
        'hobbys/', views.HobbysApi.as_view()
    ),
    path(
        'usuarios/', views.UsuariosApi.as_view()
    ),
    path(
        'usuarios/create/',
        views.UsuariosApiCreate.as_view(),
    ),
    path(
        'usuarios/update/<pk>/',
        views.UsuariosApiUpdate.as_view(),
    ),
    path(
        'usuarios/destroy/<pk>/',
        views.UsuariosApiDestroy.as_view(),
    ),
    path(
        'usuarios/retrieve/<pk>/',
        views.UsuariosApiRetrieve.as_view(),
    )
]