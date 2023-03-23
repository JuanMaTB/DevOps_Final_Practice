![TF](https://img.shields.io/badge/Supports%20Terraform%20Version-%3E%3D1.3.4-blue.svg) [![APP DEPLOY](https://github.com/KeepCodingCloudDevops6/Practica-Final-Silicon-Valley/actions/workflows/app-deploy.yaml/badge.svg)](https://github.com/KeepCodingCloudDevops6/Practica-Final-Silicon-Valley/actions/workflows/app-deploy.yaml)
[![GKE cluster](https://github.com/KeepCodingCloudDevops6/Practica-Final-Silicon-Valley/actions/workflows/gke-cluster.yaml/badge.svg)](https://github.com/KeepCodingCloudDevops6/Practica-Final-Silicon-Valley/actions/workflows/gke-cluster.yaml) [![release-build](https://github.com/KeepCodingCloudDevops6/Practica-Final-Silicon-Valley/actions/workflows/versioning-app.yaml/badge.svg)](https://github.com/KeepCodingCloudDevops6/Practica-Final-Silicon-Valley/actions/workflows/versioning-app.yaml)
# Practica-Final-Silicon-Valley 

<img src="https://user-images.githubusercontent.com/107815913/214015974-a306ba44-3ae4-4840-a334-b8e5bcf311fd.png" width="300">

## Ponentes


| | |
| ------------- | ------------- |
| [![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com/JuanMaTB)  Juan Manuel Torrado | [![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com/carlosfeufernandez)  Carlos Feu |
| [![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com/roberto-asir)  Roberto Pérez | [![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com/jacano1986)  Juan Antonio Cano |

## Agradecimientos

A los profesores de Keepcoding, queremos expresar nuestra más sincera gratitud por su orientación y apoyo durante todo el bootcamp. Su experiencia y conocimientos en DevOps han sido fundamentales para nuestro crecimiento y desarrollo como profesionales en esta área. Su paciencia y dedicación para asegurar que comprendiéramos y aplicáramos los conceptos correctamente fue excepcional. Sus retroalimentaciones y consejos nos han ayudado a superar desafíos y a mejorar nuestro trabajo continuamente. Estamos agradecidos por el tiempo y esfuerzo que han invertido en nosotros y estamos ansiosos de seguir aprendiendo en el futuro. Muchas gracias de nuevo por todo lo que han hecho por nosotros. Además agradecemos el apoyo incondicional de nuestras familias, especialmente por su paciencia y tiempo que nos han dedicado. Sin su ayuda, no habríamos podido alcanzar nuestros objetivos.

## Que pretendemos en el proyecto

Como grupo, nuestro objetivo en el proyecto final del bootcamp de DevOps es demostrar nuestra capacidad para implementar una infraestructura automatizada y escalable utilizando las tecnologías más recientes y relevantes del mercado. 

Utilizamos herramientas como Terraform para automatizar la creación de recursos en la nube, CI/CD con Github Actions para configurar una pipeline de integración y entrega continua, y el stack Grafana con Prometheus para monitorear el rendimiento de la aplicación. 

Además, desplegamos una aplicación en un cluster de Kubernetes utilizando Docker y Helm. 

Partiendo de la filosofía DevOps nuestra intención es aplicar metodología GitOps. De este modo nuestro sistema detecta estos cambios y desencadena una serie de acciones para actualizar nuestra imagen de Docker, actualizar nuestro repositorio y poner en marcha todos los componentes necesarios para versionar nuestra aplicación y mantenerla funcionando. 

Esto nos permite tener un control más preciso y eficiente sobre nuestra aplicación, asegurando que siempre esté funcionando de manera óptima.

Con este proyecto, buscamos demostrar y afianzar nuestras habilidades para construir, monitorear y escalar infraestructura en la nube, lo cual es esencial para cualquier profesional en el campo de DevOps.

https://user-images.githubusercontent.com/102614480/215438680-aa2cf9f9-c3a6-45f4-9d19-b80c359254a9.mp4

## Diagrama General
![diagrama-silicon-valley drawio (1)](https://user-images.githubusercontent.com/107815913/215150296-a371314c-338e-423d-81a2-76212735b3c6.png)


## Indice

- [Requisitos previos](#requisitos-previos)
- [Hacer funcionar nuestro proyecto](#hacer-funcionar-nuestro-proyecto)
- [La aplicación](./quiz-app/quiz-app-Readme.md)
  - [README de la aplicación](./quiz-app/README.md)
- [Docker](./quiz-app/README-docker.md)
- [Kubernetes](./k8s-app/README-kubernetes.md)
- [Helm](./quiz-app-helm/README-helm.md)
- [LA nube](./terraform-provision-gke-cluster/README-terraform.md)
- [CI/CD](./.github/workflows/README-workflows.md)
- [Monitorización](./terraform-provision-gke-cluster/assets/README-monitoring.md) 
- [Conclusiones](#conclusiones)
- [Aspectos a mejorar](#aspectos-a-mejorar)


==============================================================================================================================================

## Requisitos previos


  - [Docker](https://docs.docker.com/engine/install/ubuntu/) (si quieres usar tu propia imagen)  
  - [Git](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Instalaci%C3%B3n-de-Git) (no es estrictamente necesario) 
  - [Terraform](https://terraform-infraestructura.readthedocs.io/es/latest/instalacion/) (no es necesario si se crea el bucket manualmente)
  - [Cuenta de GCP](https://cloud.google.com/apigee/docs/hybrid/v1.4/precog-gcpaccount?hl=es-419)
  - [Instalar CLI GCP](https://cloud.google.com/sdk/docs/install?hl=es-419)
  - [Acceso al cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl?hl=es-419)
  - [Cuenta de github](https://docs.github.com/es/get-started/signing-up-for-github/signing-up-for-a-new-github-account)  
    -  [Secrets de github configurados](https://docs.github.com/es/actions/security-guides/encrypted-secrets#crear-secretos-cifrados-para-un-repositorio ) Se deben configurar los siguientes Secrets:
       * ACTIONS_STEP_DEBUG: variable de entorno que se utiliza en GitHub Actions para habilitar la salida de depuración adicional en los pasos de acción. Cuando se establece en true, se activa la salida de depuración en el paso de acción correspondiente, lo que puede ayudar a depurar problemas en los flujos de trabajo de GitHub Actions.
       * DOCKER_HUB_PWD DOCKER_HUB_USERNAME: son variables de entorno que se utilizan en GitHub Actions para iniciar sesión en Docker Hub. Estas variables almacenan el nombre de usuario y la contraseña de una cuenta de Docker Hub, y se utilizan en los pasos de acción que implican el envío de imágenes de contenedor a Docker Hub. Al establecer estas variables como secretos de GitHub, se garantiza que la información de inicio de sesión no se exponga en el repositorio.
       * GCP_SERVICE_ACCOUNT: es una variable de entorno que se utiliza en GitHub Actions para autenticar una cuenta de servicio de Google Cloud Platform (GCP). La cuenta de servicio es una entidad de seguridad que se utiliza para representar un servicio o una aplicación que accede a los recursos de GCP. Al establecer esta variable como un secreto de GitHub, se garantiza que la clave de la cuenta de servicio no se exponga en el repositorio, y solo estará disponible para los pasos de acción que la necesiten.
       * GKE_CLUSTER_NAME: es una variable de entorno que se utiliza en GitHub Actions para especificar el nombre de un clúster de Kubernetes en Google Kubernetes Engine (GKE). El clúster de Kubernetes es un conjunto de máquinas virtuales que se utilizan para ejecutar aplicaciones en contenedores. Al establecer esta variable como un secreto de GitHub, se garantiza que el nombre del clúster no se exponga en el repositorio, y solo estará disponible para los pasos de acción que la necesiten.
       * GRAFANA_ADMINPASSWD: es una variable de entorno que se utiliza en GitHub Actions para especificar la contraseña de administrador de una instancia de Grafana.
       * WORKLOAD_IDENTITY: es una variable de entorno que se utiliza en GitHub Actions para especificar la identidad de una carga de trabajo en Google Cloud Platform. La identidad de la carga de trabajo es un mecanismo de seguridad que permite a un contenedor en un clúster de Kubernetes acceder a los recursos de GCP mediante el uso de una cuenta de servicio. Al establecer esta variable como un secreto de GitHub, se garantiza que la información de identidad de la carga de trabajo no se exponga en el repositorio y solo estará disponible para los pasos de acción que la necesiten.
  - [Cuenta de dockerhub](https://hub.docker.com/signup)
  
  
## Hacer funcionar nuestro proyecto

  1. Descargar repo con    
```
git clone git@github.com:KeepCodingCloudDevops6/Practica-Final-Silicon-Valley.git
```
  2. Crear bucket para el state de terraform en gcp 
     * Moverse al directorio bucket_terraform y ejecutar:     
```
 terraform apply -auto-approve
```
  3. Con el bucket creado deberemos modificaren el directorio terraform-provision-gke-cluster, el yaml llamado bucket.tf
  
  ![Captura desde 2023-01-27 18-24-57](https://user-images.githubusercontent.com/107815913/215153849-5eea1fc3-e793-4b61-b58a-8c07e3b675e7.png)   
  
  y modificar ahí la ubicacion de nuestro bucket. Tambien se debe modificar el region y el project id que se van a utilizar en terraform.tfvars que esta ubicado en el mismo directorio.
  
  ![Captura desde 2023-01-27 18-31-02](https://user-images.githubusercontent.com/107815913/215154691-bd66df3e-2f19-4368-8b08-1ac11bfbb896.png)
  
  4. Como se aprecia en el siguiente diagrama correspondiente al flujo de nuestros workflows, al modificar nuestros archivos terraform ubicados en el directorio terraform-provision-gke-cluster, se lanzará automaticamente nuestro cluster. 


![prsctics finsl silicon-valley drawio (1)](https://user-images.githubusercontent.com/107815913/215203921-98c65e68-c0fe-4b39-b50b-442e2b79b374.png)

  

## Conclusiones

En este proyecto hemos logrado:

  * Crear una imagen de Docker a partir de una aplicación al azar y utilizarla junto con los manifiestos de Kubernetes para convertirlos en charts de Helm.
  * Desplegar un cluster de Kubernetes en GCP utilizando Terraform, lo que nos permite tener una infraestructura escalable y confiable.
  * Utilizar Github Actions para automatizar el despliegue de la aplicación y el entorno necesario incluyendo la infraestructura y software adicional requerido, lo que agiliza el proceso de desarrollo y mejora la eficiencia.
  * Desplegar un sistema de monitorización con Grafana y Prometheus, que permite tener una visibilidad en tiempo real del rendimiento de nuestra aplicación.
  * Realizar una *semantic release*  que actualiza automáticamente la imagen en Dockerhub y que edita la versión de la imagen a desplegar en el chart de Helm. Una vez hechas estas modificaciones el propio workflow lanza el despliegue del chart de helm, lo que garantiza una mayor estabilidad y seguridad en nuestra aplicación con CD.
  
En general, con este proyecto:
- hemos podido poner en práctica y afianzar los conocimientos adquiridos en el bootcamp. 
- Nos hemos enfrentado a un proyecto completo desde cero creando un entorno de trabajo que sigue los preceptos de la filosofía DevOps con el fin de  asegurar la velocidad, calidad y escalabilidad de aplicaciones.


## Aspectos a mejorar 

- A pesar de que se utiliza una imagen base ya optimizada de python habría que revisar periódicamente en busca de métodos de optimización de la imagen.
- Modificar el chart de helm para añadir configurabilidad a los despliegues con nuestro chart.
- Implementar una estrategia de despliegue canary completamente automatizada en base a parámetros de control necesarios para asegurar el correcto funionamiento de la nueva versión o en su defecto haga rollback. Estudiado posible standup con Istio + Argo CD + Flagger
- La aplicación utilizada no tenía batería de tests por lo que a la hora de generar la imagen no se hacen test de covertura ni unitarios. Este sería un punto crítico y urgente en un entorno laboral con un departamento de desarrollo propio.

