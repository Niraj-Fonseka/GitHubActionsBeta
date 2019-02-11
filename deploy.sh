#!/usr/bin/env bash

echo "#### ---- Building the docker image ---- ####"
docker build -t githubactions .

echo "#### ---- Tagging the docker image ---- ####"
docker tag githubactions gcr.io/nirajfonseka-prod/githubactions:latest

echo "#### ---- Pushing the docker image to the docker registry ---- ####"
docker push gcr.io/nirajfonseka-prod/githubactions

echo "#### ---- Resetting the deployment image ---- ####"
kubectl -n deployment set image deployment/githubactions githubactions-sha256=gcr.io/nirajfonseka-prod/githubactions:latest

kubectl -n deployment set image deployment/githubactions githubactions-sha256=gcr.io/nirajfonseka-prod/githubactions
    