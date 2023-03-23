# ¿Que nos aportan los workflows?

Los workflows nos permiten automatizar y simplificar el proceso de despliegue y actualización de nuestra aplicación.

Al estar usando herramientas como Helm, Kubernetes, Docker y Terraform, los workflows nos permiten integrar estas herramientas y crear un pipeline automatizado que se encarga de la gestión de la aplicación.

# ¿Que pretendemos hacer con nuestros workflows?

Lo que hemos hecho es crear workflows que automaticen los procesos de construcción de una imagen de Docker, implementar semantic release, su despliegue en un cluster de Kubernetes mediante Helm y la configuración del entorno con Terraform. De esta forma, cada vez que se modifica nuestra aplicación, los workflows se encargan de actualizar automáticamente la imagen, el repositorio y los componentes necesarios para dejar la aplicación funcionando. Esto ahorra tiempo y esfuerzo, permitiendo centrarnse en desarrollar nuestra aplicación en lugar de lidiar con la complejidad de la gestión del despliegue.

# Nuestros archivos para nuestros workflows

****app-deploy.yaml:**** Este archivo se utiliza para automatizar el proceso de despliegue de una aplicación en un entorno de Kubernetes utilizando Helm.
En la sección "on" se especifica cuándo se debe ejecutar el flujo de trabajo. Aquí, se ejecutará cuando se haga un push a la rama principal del repositorio y cuando otro flujo de trabajo llamado "release-build" se haya completado.
La sección "jobs" especifica las tareas a realizar en el flujo de trabajo. En este caso, se tiene una tarea llamada "app" que se ejecutará en una máquina con Ubuntu.
Los steps incluyen:

**Checkout:** descarga el código del repositorio en la máquina de ejecución.
**auth:** autentica el usuario con el proveedor de identidad de carga de trabajo y la cuenta de servicio de GCP especificados en los secretos del repositorio.
**get-credentials:** obtiene las credenciales necesarias para acceder al cluster de Kubernetes en GKE.
**get-pods:** obtiene una lista de los pods en el cluster de Kubernetes.
**install-quiz-app:** instala o actualiza la aplicación utilizando Helm.

En general, este archivo de workflow automatiza el proceso de despliegue de la aplicación en un cluster de Kubernetes utilizando Helm. Utiliza GitHub Actions y los secretos del repositorio para conectarse a GKE y automatizar el proceso de despliegue.


****gke-cluster.yaml:**** Este archivo se utiliza para automatizar tareas en GitHub Actions. Especifica un flujo de trabajo que se activa cuando se realiza una acción de "push" a una rama específica (en este caso "main") en el repositorio, y también cuando se crea un "pull request".

El "JOB" "terraform" es el primer job que se ejecuta en este flujo de trabajo. Utiliza la acción de "checkout" para descargar el código del repositorio, luego utiliza la acción "google-github-actions/auth" para autenticar con Gcloud, seguido de la acción "hashicorp/setup-terraform" para configurar Terraform. Luego ejecuta los comandos "terraform fmt", "terraform version", "terraform init" y "terraform plan", y finalmente ejecuta "terraform apply" si se cumple la condición de que el evento sea un "push" a la rama "main".

El segundo "JOB" es "operator-provisioning", que también utiliza la acción "checkout" para descargar el código del repositorio. Utiliza la acción "google-github-actions/auth" para autenticar con Gcloud y "google-github-actions/get-gke-credentials" para obtener las credenciales del clúster. Luego, utiliza Helm para instalar diferentes stacks, como prometheus, grafana, ingress-nginx y cert-manager.

****versioning-app.yaml:**** Este archivo desencadena una serie de tareas específicas que detallamos en cada step. El nombre del workflow es "versioning-app".

El workflow solo se activa cuando se realiza una acción de "push" en el repositorio de la app y sólo se ejecuta en el rama "main".
El workflow tiene una serie de permisos específicos para paquetes, contenido, pull-requests e issues.

El workflow tiene el JOB llamado "semantic-release" que se ejecuta en un sistema operativo "ubuntu-latest" y consta de varios steps:
  * **Checkout:** utiliza la acción de "actions/checkout@v2" para descargar el código del repositorio.
  * **Unshallow:** ejecuta el comando "git fetch --prune --unshallow" para descargar todo el historial del repositorio.
  * **Setup Node.js:** utiliza la acción "actions/setup-node@v3" para configurar Node.js en el sistema.
  * **Install dependencies:** ejecuta el comando "npm install" para instalar las dependencias del proyecto.
  * **Set up Docker Buildx:** utiliza la acción "docker/setup-buildx-action@v1" para configurar Docker Buildx.
  * **Docker Login in GHCR:** utiliza la acción "docker/login-action@v1" para iniciar sesión en GHCR (GitHub Container Registry) utilizando el token de GitHub.
  * **Login to DockerHub:** utiliza la acción "docker/login-action@v2" para iniciar sesión en Docker Hub utilizando un nombre de usuario y una contraseña almacenados como secretos en GitHub.
  * **Create empty semantic_release_version.txt file:** ejecuta el comando "touch semantic_release_version.txt" para crear un archivo vacío.
  * **Release:** ejecuta el comando "npx semantic-release --debug" para lanzar una nueva versión del proyecto.
  * **Get the version:** obtiene la versión actual del proyecto mediante el comando "cat semantic_release_version.txt" y la guarda en una variable de entorno.
  * **Build and push Docker image:** utiliza el comando "make publish" para construir e imprimir una imagen de Docker utilizando la versión obtenida en el paso anterior.
  * **Configure app version:** utiliza el comando "sed" para actualizar la versión de la aplicación en el archivo "values.yaml" del proyecto.
  * **Update resources:** utiliza la acción "test-room-7/action-update-file@v1" para actualizar el archivo "values.yaml" y crear un commit con el mensaje "Update .Values.appVersion" utilizando el token de GitHub.

# A continuación...

Monitorizar una aplicación es importante para detectar problemas y mejorar rendimiento. Grafana y Prometheus son herramientas populares para visualizar y recopilar datos de monitorización de aplicaciones. Juntas proporcionan una visión completa de la aplicación y ayudan a detectar problema
