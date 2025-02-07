# Service

# Basic Service

## Kubectl export
```
kubectl expose svc <service-name> -n <namespace> ...
```

## Service & Multiple Service
Ref: `service.yaml`.

## External Service
Docs: https://kubernetes.io/docs/concepts/services-networking/service/#services-without-selectors  

# Headless Service
If you want to control the load balance by your application, you can use the headless service to get the pods list.

Docs: https://kubernetes.io/docs/concepts/services-networking/service/#headless-services

# Service Type

## ClusterIP
Docs: https://kubernetes.io/docs/concepts/services-networking/service/#type-clusterip  
## NodePort
Ref: `service-node-port.yaml`.  

Docs: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport  
## LoadBalancer
Docs: https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer
## ExternalName
Docs: https://kubernetes.io/docs/concepts/services-networking/service/#externalname  