# litecoin-docker-k8s

This Docker file will build an Ubuntu 18.04 based Litecoin daemon with data stored at /litecoin.

In Google Cloud's Kubernetes running kubectl create -f Litecoin-gce.yaml will run this docker container with a persistent volume at /litecoin.
