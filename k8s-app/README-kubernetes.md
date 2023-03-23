# ¿Porqué usamos Kubernetes?

Hemos decidido usar Kubernetes debido a su capacidad para escalar automáticamente y administrar nuestra aplicación en un ambiente distribuido. Además, Kubernetes proporciona características de alta disponibilidad, tolerancia a fallos y balanceo de carga, lo que garantiza una mayor estabilidad y disponibilidad de nuestra aplicación. También nos ha gustado la facilidad de uso y la gran cantidad de herramientas junto a los multiples recursos útiles para ayudarnos en el proceso de despliegue y administración de nuestra aplicación. Nuestra conclusión, es que Kubernetes es la mejor opción para nuestro proyecto debido a su escalabilidad, disponibilidad, tolerancia a fallos, facilidad de uso y la gran comunidad de desarrolladores.

# Nuestros manifiestos de Kubernetes

Los manifiestos de Kubernetes son esenciales para el despliegue automatizado y reproducible de nuestra aplicación. Describen y definen la configuración de los recursos del sistema, como el número de réplicas, los contenedores necesarios, la configuración de volumen, los servicios y las clases de almacenamiento. Estos manifiestos son esenciales para asegurar que nuestra aplicación se despliegue y se ejecute correctamente en un cluster de Kubernetes.

[deployment-app.yaml](./deployment-app.yaml): Este archivo contiene la configuración para desplegar la aplicación en un cluster de Kubernetes. Incluye detalles como el número de réplicas, los contenedores necesarios y las configuraciones de volumen.

[deployment-db.yaml](./deployment-db.yaml): Similar al archivo anterior, pero para desplegar una base de datos.

[namespace.yaml](./namespace.yaml): Este archivo se utiliza para crear un "namespace" dentro del cluster de Kubernetes, el cual se utiliza para aislar los recursos de diferentes equipos o proyectos dentro de la misma instancia de Kubernetes.

[secret-config.yaml](./secret-config.yaml): Este archivo contiene información confidencial, como contraseñas y tokens, que se utilizan en la aplicación y son necesarias para su funcionamiento.

[service-app.yaml](./service-app.yaml): Este archivo define un servicio para la aplicación, que permite a los usuarios acceder a ella a través de una dirección IP o un nombre de dominio.

[service-db.yaml](./service-db.yaml): Similar al archivo anterior, pero para el servicio de la base de datos.

[ssl-cert.yaml](./ssl-cert.yaml): Este archivo contiene la configuración para un certificado SSL, que se utiliza para garantizar la conexión segura entre el usuario y la aplicación.

[storageClass.yaml](./storageClass.yaml): Este archivo define la configuración para una clase de almacenamiento, que se utiliza para controlar cómo se almacenan los datos en una base de datos.


Cada uno de estos manifiestos tiene un papel específico en el despliegue y configuración de nuestra aplicación en un cluster de Kubernetes, juntos trabajan para asegurar que la aplicación esté disponible y sea segura para los usuarios, además de que los recursos estén aislados y se manejen de forma adecuada.

Además, hemos analizado y descrito con mas detalle las secciones más relevantes de nuestros manifiestos de Kubernetes, proporcionando explicaciones detalladas de cómo se utilizan y para qué sirven.

# A continuacion...

Procederemos a crear los manifiestos de [Helm](../quiz-app-helm/README-helm.md) que nos permitirán llevar a cabo el despliegue de manera eficiente.
