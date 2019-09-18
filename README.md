# litecoin-docker-k8s

This Docker file will build an Ubuntu 18.04 based Litecoin daemon with data stored at /litecoin.

Using Google Cloud's Kubernetes running ```kubectl create -f litecoin-gce.yaml``` will run this container with a persistent volume at /litecoin.
