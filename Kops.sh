#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

#install aws cli 
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

#! /bin/bash
#aws configure
#kubectl setup
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
#Kops setup
wget https://github.com/kubernetes/kops/releases/download/v1.30.3/kops-linux-amd64
chmod +x kops-linux-amd64
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket suresh0402.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket suresh0402.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://suresh0402.k8s.local
kops create cluster --name suresh.k8s.local --zones us-east-1a,us-east-1b --master-count 1 --master-size t2.medium --master-volume-size 30 --node-count 2 --node-size t2.micro --node-volume-size 20
#kops create cluster --name suresh.k8s.local --zones us-east-1a --master-count=1 --master-size t2.medium --node-count=2 --node-size t2.medium
kops update cluster --name suresh.k8s.local --yes --admin

#TO DELETE THE CLUSTER 
#export KOPS_STATE_STORE=s3://your-bucket-name
#kops get cluster 
#kops delete cluster cluster-name --yes

# * list clusters with: kops get cluster
# * edit this cluster with: kops edit cluster suresh.k8s.local
# * edit your node instance group: kops edit ig --name=suresh.k8s.local nodes-us-east-1a
# * edit your control-plane instance group: kops edit ig --name=suresh.k8s.local control-plane-us-east-1a
