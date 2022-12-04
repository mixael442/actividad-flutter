from rest_framework import serializers

from actividad.registros.models import Hobbys, Peliculas, Usuarios

class UsuariosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuarios
        fields = ('__all__')


class PeliculasSerializer(serializers.ModelSerializer):
    class Meta:
        model = Peliculas
        fields = ('__all__')


class HobbysSerializer(serializers.ModelSerializer):
    class Meta:
        model = Hobbys
        fields = ('__all__')