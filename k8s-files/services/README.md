# Service Introductions

# Basic Service

## Kubectl export
```
kubectl expose svc <service-name> -n <namespace> ...
```

## Service & Multiple Service
Check `service.yaml`

## External Service
Docs: https://kubernetes.io/docs/concepts/services-networking/service/#services-without-selectors  

# Headless Service
If you want to control the load balance by your application, you can use the headless service to get the pods list.

Docs: https://kubernetes.io/docs/concepts/services-networking/service/#headless-services