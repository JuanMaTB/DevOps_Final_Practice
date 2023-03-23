# Roberto 13-12-2022
# Comando que se ejecuta sin parámetros
# Lanza el despliegue de todos los manifiestos en el orden correcto
# Deprecable cuando tengamos un chart de helm de la app

MANIFESTS=$(echo """k8s-app/namespace.yaml
k8s-app/secret-config.yaml
k8s-app/storageClass.yaml
k8s-app/service-db.yaml
k8s-app/service-app.yaml
k8s-app/ingress.yaml
k8s-app/deployment-app.yaml
k8s-app/deployment-db.yaml""" | tr '\n' ' ')


for MANIF in $(echo $MANIFESTS); do
  kubectl apply -f $MANIF
done

kubectl get -n practica pods
kubectl get -n practica svc
kubectl get -n practica secrets
