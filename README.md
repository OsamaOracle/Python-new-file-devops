# Python-new-file-devops
 a python app that writes a new file to S3 on every execution. These files need to be maintained only for 24h using terraform

# the requirements
You need to develop and deploy a python app that writes a new file to S3 on every execution. These files need to be maintained only for 24h.

The content of the file is not important, but add the date and time as prefix for you files name.

The name of the buckets should be the following ones for QA and Staging respectively:

qa-FIRSTNAME-LASTNAME-platform-challenge

staging-FIRSTNAME-LASTNAME-platform-challenge

The app will  be running as a docker container in a Kubernetes cluster every 5 minutes. There is a Namespace for QA and a different Namespace for Staging in the cluster. You don't need to provide tests but you need to be sure the app will work. 

# Deployment--

If you need, you can use localstack ( https://github.com/localstack/localstack ( https://github.com/localstack/localstack ) as mock for having a S3 bucket locally and running your app.

Along with the python code you need to provide Terraform resources to provision the S3 bucket (and its associated resources), as well as a Kubernetes resource that will run the application as described. 

# steps

1- install aws cli and run aws configure, to enter your credential  
2- go to terraform repo, change region,first and last name in s3.tfvar  
3- do : terraform init  after that do : terraform apply --var-file s3.tfvar  

4- go to docker repo and run : docker build -t boto3test:v1.   
PS : you can change the name and tag but you need to change also if kubernetes_part  

5- go to kubernetes repo  
6- in setSecrets.yaml : put your key and secret  
7- in jobScript.yaml : change first and last name  

8- create a cron:  
     crontab -e  
   and at the end of file put:  
   */5 * * * * kubectl delete -f /path/to/jobScript.yaml --namespace=qa || true  && kubectl delete -f /path/to/jobScript.yaml --namespace=staging || true  && kubectl apply -f /path/to/jobScript.yaml --namespace=qa && kubectl apply -f /path/to/jobScript.yaml --namespace=staging  
 
PS : change /path/to/  
PS2 : you need to create the secret in both namespaces before creating the cron  
kubectl apply -f /path/to/setSecrets.yaml --namespace=qa  
kubectl apply -f /path/to/setSecrets.yaml --namespace=staging  
