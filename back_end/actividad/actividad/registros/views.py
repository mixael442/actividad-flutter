from django.shortcuts import render
from rest_framework.generics import ListAPIView, CreateAPIView, DestroyAPIView, UpdateAPIView, RetrieveAPIView
from actividad.registros.models import Hobbys, Peliculas, Usuarios
from actividad.registros.serializers import HobbysSerializer, PeliculasSerializer, UsuariosSerializer
# Create your views here.

class UsuariosApi(ListAPIView):
    serializer_class = UsuariosSerializer
    def get_queryset(self):
        return Usuarios.objects.all()

class UsuariosApiCreate(CreateAPIView):
    serializer_class=UsuariosSerializer
    def get_queryset(self):
        return Usuarios.objects.all()

class UsuariosApiDestroy(DestroyAPIView):
    serializer_class=UsuariosSerializer
    def get_queryset(self):
        return Usuarios.objects.all()

class UsuariosApiUpdate(UpdateAPIView):
    serializer_class=UsuariosSerializer
    def get_queryset(self):
        return Usuarios.objects.all()

class UsuariosApiRetrieve(RetrieveAPIView):
    serializer_class=UsuariosSerializer
    def get_queryset(self):
        return Usuarios.objects.all()




class PeliculasApi(ListAPIView):
    serializer_class = PeliculasSerializer
    def get_queryset(self):
        return Peliculas.objects.all()



class HobbysApi(ListAPIView):
    serializer_class = HobbysSerializer
    def get_queryset(self):
        return Hobbys.objects.all()