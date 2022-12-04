from django.db import models

# Create your models here.

class Hobbys(models.Model):
    hobby = models.CharField('Hobby', blank=False, max_length=25)
    #imagen = models.ImageField()

class Peliculas(models.Model):

    pelicula = models.CharField('Pelicula Favorita', blank=False, max_length=25)
    recaudacion = models.CharField('Recaudacion', blank=True, max_length=25)
    presupuesto = models.CharField('Presupuesto', blank=True, max_length=25)
    #imagen = models.ImageField()

    def __str__(self) -> str:
        return self.pelicula 

class Usuarios(models.Model):
    hobby = models.ForeignKey(Hobbys, on_delete=models.DO_NOTHING, default=1)
    pelicula_favorita = models.ForeignKey(Peliculas, on_delete=models.DO_NOTHING)
    nombre = models.CharField('Nombre', blank=True, max_length=20)
    apellido = models.CharField('apellido', blank=True, max_length=20)
    dni = models.CharField('DNI', blank=True, max_length=20)
    fecha_creacion = models.DateTimeField(auto_now_add=True, auto_now=False, blank=True,)
    fecha_nacimiento  = models.DateField('Fecha de Nacimiento')
    sueldo_mensual = models.CharField('Sueldo Mensual', blank=True, max_length=20)
    

    def __str__ (self):
        return self.nombre + ' ' + self.apellido + ' ' + str(self.fecha_creacion)


