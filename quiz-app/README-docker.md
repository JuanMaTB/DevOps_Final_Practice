# ¿Porqué usamos Docker?

Después de evaluar varias opciones, decidimos utilizar Docker en nuestro proyecto de práctica final de DevOps debido a las ventajas que ofrece. En particular, nos atrajo la portabilidad que proporciona, lo que nos permite mover fácilmente nuestra aplicación entre diferentes entornos. También nos gustó el nivel adicional de aislamiento que proporciona entre las aplicaciones, lo que ayudará a evitar conflictos de dependencias y configuraciones. Además, la interfaz de línea de comandos fácil de usar y la gran comunidad de desarrolladores que han creado una gran cantidad de contenedores de aplicaciones de software libre para una variedad de plataformas nos ayudará a hacer el trabajo más fácil. Y la escalabilidad y el ahorro de recursos que ofrece también son ventajas importantes para nuestro proyecto. En resumen, creemos que Docker es la mejor opción para nuestro proyecto de práctica final de DevOps debido a su portabilidad, aislamiento, facilidad de uso, escalabilidad y ahorro de recursos.

# El Dockerfile
Usamos Dockerfile para crear imágenes de contenedores automatizadas que encapsulan nuestra aplicación y sus dependencias. Esto nos permite desplegar nuestra aplicación de manera consistente y predecible en cualquier entorno. Además, Dockerfile nos permite escalar fácilmente nuestra aplicación y mejorar la eficiencia en el uso de recursos.

# Explicando nuestro Dockerfile 

```
FROM python:3.10-alpine AS base

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . ./

EXPOSE 5000

CMD python server.py
```

Este Dockerfile es un ejemplo de cómo construimos nuestra imagen de contenedor para nuestra aplicación Python. A continuación se explica cada línea:

**FROM python:3.10-alpine AS base**: Esta línea especifica la imagen base que se utilizará para construir la imagen del contenedor. En este caso, se está utilizando la imagen oficial de Python en su versión 3.10, construida sobre Alpine Linux. Además, se establece un alias "base" para esta imagen base.

**WORKDIR /app**: Esta línea establece el directorio de trabajo dentro del contenedor donde se ejecutarán los comandos siguientes. En este caso, se establece el directorio "/app" como el directorio de trabajo.

**COPY requirements.txt requirements.txt**: Esta línea copia el archivo "requirements.txt" desde el sistema host al contenedor en el directorio de trabajo establecido anteriormente. Este archivo contiene las dependencias de Python que necesita la aplicación para funcionar.

**RUN pip install -r requirements.txt**: Esta línea ejecuta el comando "pip install" dentro del contenedor para instalar las dependencias especificadas en el archivo "requirements.txt" copiado anteriormente.

**COPY . ./**: Esta línea copia todos los archivos del directorio actual en el sistema host al directorio de trabajo dentro del contenedor.

**EXPOSE 5000**: Esta línea indica al contenedor que debe exponer el puerto 5000. Esto significa que el contenedor puede recibir tráfico en ese puerto.

**CMD python server.py**: Esta línea especifica el comando que se ejecutará cuando se inicie el contenedor. En este caso, se está ejecutando el archivo "server.py" mediante el intérprete de Python.

En resumen, este Dockerfile especifica cómo construir una imagen de contenedor para una aplicación Python utilizando la imagen base de Python en su versión 3.10 sobre Alpine Linux, se copian los archivos necesarios y se instalan las dependencias especificadas en el archivo "requirements.txt", se expone el puerto 5000 y se ejecuta el comando python server.py al iniciar el contenedor.

# Construyendo nuestra imagen.

Construimos una imagen desde un Dockerfile mediante el comando "docker build" especificando el nombre y etiqueta de la imagen "carlosfeufernandez/app-quiz-pf" y indicando el archivo Dockerfile en el directorio actual. Este proceso permite automatizar la creación de imágenes que encapsulan nuestra aplicación y sus dependencias, permitiendo desplegarla de manera consistente y predecible en cualquier entorno.

```
docker build -t carlosfeufernandez/app-quiz-pf .
```

# El docker-compose 

Usamos Docker Compose en nuestro proyecto para facilitar la configuración y el despliegue de varios contenedores relacionados. Docker Compose nos permite especificar en un archivo "docker-compose.yml" los contenedores, volúmenes, redes y configuraciones necesarias para ejecutar nuestra aplicación, permitiéndonos iniciar y detener todos los contenedores de manera fácil y automatizada. Además, Docker Compose nos permite escalar fácilmente nuestros servicios y mejorar la eficiencia en el uso de recursos.

# Explicando nuestro Docker-compose 

```
version: '3.1'
services:
    mongo:
      image: mongo
      container_name: mongodb
      environment:
        MONGO_INITDB_ROOT_USERNAME: admin
        MONGO_INITDB_ROOT_PASSWORD: admin1
      ports:
        - 27017:27017

      
    app:
      depends_on:
        - "mongo"
      image: carlosfeufernandez/app-quiz-pf
      ports: 
        - 5000:5000
      environment:
        # MONGO_INITDB_ROOT_USERNAME: admin
        # MONGO_INITDB_ROOT_PASSWORD: admin1
        MONGODB_URI: mongodb://admin:admin1@mongo:27017/
```

Básicamente, este archivo "docker-compose.yaml" especifica la versión de Docker Compose y dos servicios "mongo" y "app" que se van a desplegar, especificando las imagenes a utilizar, los nombres de los contenedores, las variables de entorno, las dependencias y los puertos a exponer.

**version: '3.1'**: Esta línea especifica la versión de Docker Compose que se está utilizando en este archivo.

**services:**: Esta sección especifica los servicios o contenedores que se van a desplegar.

**mongo:**: Este es el primer servicio que se va a desplegar, y utiliza una imagen oficial de MongoDB.

**image: mongo**: Esta línea especifica la imagen que se va a utilizar para este servicio. En este caso se utiliza la imagen oficial de MongoDB.

**container_name**: mongodb: Esta línea especifica el nombre del contenedor que se creará al ejecutar este servicio.

**environment:**: Esta sección especifica las variables de entorno que se deben establecer en el contenedor.

**MONGO_INITDB_ROOT_USERNAME: admin y MONGO_INITDB_ROOT_PASSWORD: admin1**: Estas líneas establecen el nombre de usuario y la contraseña para el usuario root de MongoDB.

**ports:**: Esta sección especifica los puertos que se deben exponer. En este caso, se está exponiendo el puerto 27017 del contenedor al puerto 27017 del host.

**app:**: Este es el segundo servicio que se va a desplegar, y utiliza una imagen construida desde un Dockerfile con el nombre carlosfeufernandez/app-quiz-pf.

**depends_on:**: Esta sección especifica que este servicio depende del servicio "mongo" para poder funcionar.

**ports:**: Esta sección especifica los puertos que se deben exponer. En este caso, se está exponiendo el puerto 5000 del contenedor al puerto 5000 del host.

**environment:**: Esta sección especifica las variables de entorno que se deben establecer en el contenedor.

**MONGODB_URI: mongodb://admin:admin1@mongo:27017/**: Esta línea establece la dirección de la base de datos MongoDB que se va a utilizar.


# Ejecutando Docker-compose

Para ejecutar el archivo "docker-compose.yaml" anterior, se debe ejecutar el comando en la terminal desde el directorio donde se encuentra el archivo.
```
docker-compose up
``` 
Este comando iniciará los contenedores especificados en el archivo, y los mantendrá ejecutándose en segundo plano. También se puede usar para ejecutar los contenedores en segundo plano.

```
docker-compose up -d
```
# A continuación...

El siguiente paso es utilizar [Kubernetes](../k8s-app/README-kubernetes.md) para escalar y administrar nuestra aplicación mediante el uso de sus manifiestos y características de orquestación de contenedores. 
