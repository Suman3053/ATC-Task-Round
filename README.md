# Static Web Application Deployment with Kubernetes, Terraform, Prometheus, and Grafana

## Pre-requisites

This should be installed on our system

1. **Docker Desktop** (with Kubernetes enabled)
2. **Terraform**
3. **kubectl** command-line tool configured to interact with your Kubernetes cluster
4. **Docker Hub Account** (for pushing images)

### Step 1: Provision Infrastructure with Terraform

Navigate to the terraform-files directory

1. **Initialize Terraform**:
   terraform init - intialization
   terraform fmt - for formatting our code
   terraform validate - to validate our script for any syntax errors
   terraform plan - to peform the dry run to know what actually the resources wee are going to create
   terraform apply - to create the infrastructure in provider which you have provided

### step 2: Containerize the Static Web Application

Navigate to the static-web directory

1. Create a simple index.html static site.
2. Create a Dockerfile using NGINX to serve the static HTML.
 
**Docker commands to run**
1. docker build -t <image-name> . - to buil the image use -f /dockerfilepath if you have used different name for your dockerfile.
2. docker tag <image-name> <dockerhub-username>/atc-task:v1 -tagging our image with dockerhub repo name to push on dockerhub.
3. docker push <dockerhub-username>/atc-task:v1 - push your tagged docker image to dockerhub repo.

### Step 3: Deploy on Kubernetes

Navigate to the kubernetes-files directory

Create deployment.yaml and service.yaml to define your application deployment and service. 
deployment to handle the pods and service for network pusposes where it can assign ip addr and also do a little load balancing.

**kubernetes commands**
1. kubectl apply -f <deployment, service> - use this command to create configurations.
2. kubectl get pods, service - to check the created pods and service.
3. kubectl describe pods <podname>, kubectl logs <podname> - to perform the debugging by checking the pod logs using this commands.

### step 4 : Set Up Monitoring with Prometheus and Grafana

Navigate to monitoring-files directory to deploy proetheus and grafana

**kubernetes commands**
1. kubectl apply -f <prometheus-deploy.yaml, grafana.yaml> to deploy the configuration
2. kubectl get pods - to check the deployed configuation
3. kubectl port-forward svc/grafana-deploy 3000:3000, kubectl port-forward svc/prometheus-deploy 9090:9090
 - to forward the port

4. to access grafana and promethues dashboard use this port numbers 9090 - prometheus and 3000 for grafana.
5. kubectl port-forward pod/static-web-app-76d8795875-gl7jg 8080:80 - if our pod exposing to port 80 then we can forward te port running to port 8080:80
6. we can now open the application in our browser by visiting http://localhost:8080


