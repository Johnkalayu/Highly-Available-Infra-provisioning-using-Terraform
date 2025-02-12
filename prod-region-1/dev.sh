#!bin/bash
sudo yum update && sudo yum upgrade -y 
sudo amazon-linux-extras install java-openjdk11
# installing docker 
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -aG docker  ec2-user
sudo useradd -aG docker ssm-user
sudo systemctl restart docker


sudo chmod 666 /var/run/docke.sock

docker pull jonathan/openproject
docker run -e DATABASE_URL=postgres://openproject:openproject@${postgres_url}/openproject -p 8080:8080 docker.io/jonathan/openproject