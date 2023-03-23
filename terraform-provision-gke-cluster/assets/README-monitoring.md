# ¿Porque hay que monitorizar?

Monitorizar una aplicación es importante porque permite detectar problemas de rendimiento y errores en tiempo real. Esto ayuda a garantizar que la aplicación esté disponible y responda rápidamente para los usuarios. Además, la monitorización permite recopilar datos sobre el uso de la aplicación, lo que ayuda a identificar áreas para mejorar y optimizar.

# ¿Porque el stack Grafana Prometheus?

Grafana y Prometheus son las herramientas mas populares para monitorizar aplicaciones. 

Grafana es una herramienta de visualización de datos que permite crear dashboards y gráficos facilmente para visualizar los datos recopilados. 

Prometheus es un sistema de recopilación de datos y almacenamiento de tiempo de ejecución que se utiliza para recopilar y almacenar los datos de monitorización.

Ambos se utilizan juntos para proporcionar una visión completa de la aplicación y ayudar a detectar problemas.

# Instalación de nuestro stack

Hemos utilizado el Helm de Prometheus, que ya consta de Grafana, para aprovechar las ventajas de Helm para manejar la configuración y las dependencias de las aplicaciones de manera automatizada. Gracias a ello, hemos instalado y desplegado Prometheus y Grafana de manera rápida y sencilla, lo que nos ayuda a reducir el tiempo y los esfuerzos necesarios para configurar y mantener un ambiente de monitorización.

Al desplegar Prometheus y Grafana con Terraform, aprovechamos su poder para automatizar la creación y configuración de la infraestructura necesaria para alojar las aplicaciones de monitorización. Utilizar Terraform permite tener un control mas preciso y detallado sobre el despliegue de nuestra infraestructura. Esto nos permite mantener un ambiente de monitorización estable y escalable, con la posibilidad de replicarlo en diferentes entornos de manera automatizada y confiable. Además, al tener nuestra configuración de infraestructura como código, es mas fácil de versionar y controlar cambios a nuestra configuración.

# El ingress de Grafana

Este Ingress de Grafana se utiliza para controlar cómo los clientes externos se comunican con una aplicación desplegada en un clúster de Kubernetes. Este Ingress especifica que cuando los clientes accedan a la dirección "grafana.robertoasir.com", se deben redirigir a un servicio específico llamado "prometheus-grafana-lb" en el puerto 3000.

El Ingress también especifica que se debe utilizar la clase de ingreso "nginx" para manejar las solicitudes entrantes. Además, el path '/' es el que se utiliza para acceder a la aplicacion de Grafana. También esté configurado para proporcionar un balanceo de carga y protección contra ataques DDoS para la aplicación de Grafana.

# Certificados SSL/TLS
 el archivo ssl-cert.yaml es un recurso de Cert-manager que se utiliza para emitir y renovar certificados SSL/TLS para su aplicación. Este recurso específicamente configura un "Emisor" de Let's Encrypt que se utilizará para obtener un certificado SSL/TLS para la aplicación de Grafana.
 
El correo electrónico especificado se utilizará para recibir notificaciones relacionadas con la expiración de certificados y problemas relacionados con la cuenta. El servidor especificado es el servidor de Let's Encrypt que se utilizará para obtener el certificado. La clave privada se almacenará en un recurso de secreto especificado. La configuración de solvers especifica el método de desafío para validar la propiedad del dominio, en este caso se utiliza el método http01 con nginx.

Incluyendo este archivo en la sección de monitorización se asegura que el certificado se emitirá y renovará automáticamente, garantizando que la conexión a la aplicación de Grafana siempre esté protegida mediante un certificado SSL/TLS válido.
