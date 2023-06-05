#!/bin/bash

username=$(whoami)

sudo kubectl create role microservices_admin \
  --verb=get,list,watch,create,update,patch,delete \
  --resource=pods,services,replicationcontrollers,deployments,statefulsets,persistentvolumeclaims,events \
  --namespace=microservices
sudo kubectl create rolebinding microservices_admin \
  --role=microservices_admin \
  --user=$username \
  --namespace=microservices
