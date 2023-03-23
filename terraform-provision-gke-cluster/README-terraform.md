# ¿Porque usamos la nube?

La nube es importante porque ofrece una gran escalabilidad, flexibilidad y eficiencia en cuanto a costos, ya que permite a las empresas pagar solo por lo que usan en lugar de tener que invertir en infraestructura costosa y mantenerla. Además, la nube también permite a las empresas experimentar con nuevas tecnologías y soluciones de manera rápida y fácil.

Para un devops, la nube ofrece una variedad de herramientas y servicios que pueden ayudar a automatizar y optimizar el proceso de entrega y operación de software. Esto incluye servicios de integración y entrega continua, orquestación de contenedores y automatización de infraestructura, entre otros. Esto permite a los equipos de devops ser más eficientes y entregar software de manera más rápida y segura.

# La eleccion de proveedor

Google Cloud Platform (GCP) es una excelente opción como proveedor de nube debido a su bajo costo y su integración con Kubernetes.

En primer lugar, GCP ofrece una gran flexibilidad en cuanto a precios, lo que permite a las empresas pagar solo por lo que usan. Además, GCP tiene una variedad de herramientas y servicios que ayudan a reducir los costos, como la capacidad de escalar automáticamente la infraestructura según la demanda y la posibilidad de reservar recursos a largo plazo a precios más bajos.

En segundo lugar, GCP es uno de los mejores proveedores de nube en cuanto a su integración con Kubernetes. GCP ofrece un servicio de Kubernetes nativo llamado Google Kubernetes Engine (GKE) que permite a los equipos de devops desplegar y operar aplicaciones en Kubernetes de manera fácil y segura.

En tercer lugar, GCP es conocido por su facilidad de uso y su interfaz intuitiva, como devops nos ha permitido crear, desplegar y escalar infraestructura de manera rápida y sencilla. Esto se debe a que GCP ofrece una gran variedad de herramientas de automatización y una interfaz de línea de comandos fácil de usar.

Como conclusión, GCP es una excelente opción como proveedor de nube debido a su bajo costo, su integración con Kubernetes y su facilidad de uso.

# Terraform

Terraform es la herramienta de automatización de infraestructura que hemos elegido. Nos permite describir la infraestructura de una aplicación como código. Al usar Terraform, se pueden crear, actualizar y eliminar recursos de nube de manera automatizada y segura. Esto nos permite, como equipo devops aprovisionar y gestionar infraestructura de manera consistente y eficiente.

Además, integrando Terraform con GitHub Actions, se pueden automatizar los workflows de entrega y operación de software, permitiendo que los equipos implementen cambios de manera rápida y segura. Al crear un flujo de trabajo de GitHub Actions que invoque Terraform, se pueden automatizar tareas como la creación o actualización de recursos en GCP, lo que permite a los equipos de devops mantener una infraestructura estable y segura.

Resumiendo, utilizar Terraform junto con GitHub Actions es una excelente opción para automatizar el despliegue y la gestión de infraestructura en GCP, ya que permite a los equipos de devops describir su infraestructura como código y automatizar los workflows de entrega y operación de software. 

# El estado de Terraform

El motivo de almacenar el estado de Terraform en un bucket de GCP se debe a la necesidad de compartir el estado entre diferentes miembros de un equipo de desarrollo. El estado de Terraform es un archivo que contiene información sobre los recursos provisionados en un entorno, como la configuración de una máquina virtual o el estado de una red. Al almacenar el estado en un bucket de GCP, todos los miembros del equipo pueden acceder al mismo archivo y ver la misma información. Esto permite una mayor colaboración y transparencia en el equipo, ya que todos pueden ver las acciones realizadas en el entorno.

Además, almacenar el estado en un bucket de GCP también proporciona una mayor seguridad ya que el estado se guarda en un lugar seguro y seguridad en la nube, también facilita la recuperación en caso de fallos o problemas.

# Los archivos de Terraform

[backend.tf](./backend.tf): El archivo backend.tf es un archivo de configuración de Terraform que especifica cómo y dónde se almacenará el estado de Terraform. Este archivo especifica que se está utilizando el backend de GCS (Google Cloud Storage) para almacenar el estado de Terraform. El archivo especifica el nombre del bucket en el cual se almacenará el estado de Terraform y un prefijo que se utilizará para el archivo de estado en el bucket especificado. En resumen, el archivo backend.tf configura el almacenamiento en la nube del estado de Terraform para permitir la colaboración y la transparencia entre los miembros del equipo.

[gke.tf](./gke.tf): Este archivo gke.tf es un archivo de configuración de Terraform que se utiliza para crear y configurar un clúster de Kubernetes en Google Kubernetes Engine (GKE).
En primer lugar, se declaran tres variables: "gke_username", "gke_password" y "gke_num_nodes". La variable "gke_username" y "gke_password" son credenciales de acceso necesarias para crear y administrar el clúster de GKE. La variable "gke_num_nodes" especifica el número de nodos que se utilizarán en el clúster.
A continuación, se utiliza el recurso "google_container_cluster" para crear el clúster de GKE. El nombre del clúster se establece en una variable "${var.project_id}-gke", y su ubicación se establece en una variable "var.region". Se configura el clúster para no tener un nodo pool por defecto y se establece el número inicial de nodos en 1.
Luego, se utiliza el recurso "google_container_node_pool" para crear un nodo pool separado. El nombre del nodo pool se establece en una variable "${google_container_cluster.primary.name}", su ubicación se establece en una variable "var.region" y se especifica el número de nodos que se utilizarán en el clúster.
Por último, se utiliza el proveedor "kubernetes" para configurar el acceso al clúster de GKE. Se especifica que se cargará el archivo de configuración de forma manual, se establecen las credenciales de acceso y se proporciona la información necesaria para autenticar la conexión al clúster.

[kubernetes-dashboard-admin-rbac.yaml](./kubernetes-dashboard-admin-rbac.yaml): se utiliza para configurar los permisos de un usuario en el dashboard de Kubernetes.
El archivo consta de dos secciones:
La primera sección, "apiVersion: v1 kind: ServiceAccount" define una cuenta de servicio llamada "admin-user" en el namespace "kube-system".
La segunda sección, "apiVersion: rbac.authorization.k8s.io/v1 kind: ClusterRoleBinding" define una asociación de rol de clúster llamada "admin-user" que otorga al usuario "admin-user" los permisos del rol "cluster-admin" en todo el clúster.
Como consecuencia, este archivo se utiliza para crear una cuenta de servicio llamada "admin-user" en el namespace "kube-system" y darle acceso de administrador en todo el clúster a esa cuenta de servicio en el dashboard de Kubernetes. Esto significa que el usuario "admin-user" tendrá acceso completo para administrar y gestionar recursos en el clúster mediante el dashboard de Kubernetes.

Hemos tenido en cuenta que esta configuración es referente al uso del Dashboard de Kubernetes y no al uso de Terraform con Kubernetes, pero lo hemos incluido dentro de Terraform porque la intención era asignar roles y permisos dentro del cluster que desplegamos como infraestructura.

[outputs.tf](./outputs.tf):Es utilizado para especificar las salidas que Terraform debe mostrar una vez que se hayan aplicado los cambios. En este caso, se establecen cuatro salidas: "region", "project_id", "kubernetes_cluster_name" y "kubernetes_cluster_host". Estas salidas son para verificar y obtener informacion especifica de la infraestructura que se esta creando con terraform, como el nombre del cluster o el id del proyecto

[terraform.tfvars](./terraform.tfvars): es utilizado para especificar los valores de las variables utilizadas en los archivos de configuración de Terraform. En este caso, especifica el ID del proyecto y la región en la que se crearán los recursos en GCP. Al ejecutar el comando terraform apply, Terraform utilizará estos valores para crear los recursos en el proyecto y la región especificados. 

[versions.tf](./versions.tf): Creado para especificar las versiones de los recursos o módulos que se utilizarán en el proyecto. En este caso, se está especificando que se requiere de la versión 4.27.0 del proveedor de Google de Terraform y que se requiere una versión de Terraform mayor o igual a 0.14. Esto garantiza que la configuración funcione correctamente con las versiones especificadas de los proveedores y de Terraform.

[vpc.tf](./vpc.tf): Usamos este archivo para crear una red virtual privada (VPC) y una subred en Google Cloud Platform (GCP) mediante el proveedor de Terraform de Google.
En primer lugar, se definen dos variables: "project_id" y "region". Estas variables se utilizan para especificar el ID del proyecto y la región en GCP en la que se crearán la VPC y la subred.
Luego, se define el proveedor de Google, especificando el ID del proyecto y la región de las variables anteriores.
Por último, se utilizan los recursos de Terraform "google_compute_network" y "google_compute_subnetwork" para crear una VPC y una subred, respectivamente. La VPC se llama "${var.project_id}-vpc" y se establece la opción "auto_create_subnetworks" en "false" para indicar que no se crearán automáticamente subredes dentro de la VPC. La subred se llama "${var.project_id}-subnet", se ubica en la región especificada en la variable "region", se asocia con la VPC creada
