#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

echo "Installing Docker..."
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user   # Ensure current user can run Docker

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl

echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm -f minikube-linux-amd64

echo "Installing required dependencies..."
sudo yum install -y iptables conntrack

echo "Starting Minikube..."
# --force is rarely needed unless you're overriding previous settings.
#minikube start --driver=docker
minikube start --driver=docker --force


echo "Verifying Minikube installation..."
minikube status
kubectl get nodes

echo " Minikube setup complete!"
echo "Please log out and log back in (or run 'newgrp docker') to use Docker without sudo."

