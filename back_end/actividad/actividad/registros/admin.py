from django.contrib import admin
from actividad.registros.models import  Peliculas, Usuarios, Hobbys

# Register your models here.
admin.site.register(Usuarios)
admin.site.register(Peliculas)
admin.site.register(Hobbys)
