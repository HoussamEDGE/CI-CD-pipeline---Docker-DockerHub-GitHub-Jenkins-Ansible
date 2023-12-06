# CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible

##I- Set up environnement :
###1 - Create 4 VM s (EC2 instances) in AWS :
while creating the instances assign to them a key pair that you have created , in my case its ubuntu-key , its a private key generated with RSA algorithm which is an asymmetric cryptography algorithm since its based on 2 keys (private/public) used for encryption and decryption .

![Screenshot 2023-12-05 085322](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/3b79a9f5-9b79-4411-aca7-fc70e58d1b4b)


![Screenshot 2023-12-06 111239](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/77722d41-6394-4dd1-b974-38904aee6e7c)

to connect using ssh with EC2 instance : 

ssh -i ubuntu-key.pem ubuntu@publicIPaddofinstance

###2- Set up Jenkins Server :

We set hostname to Jenkins (just to know what server we are using when interacting in cmd /ssh) :
```
sudo su
hostnamectl set-hostname Jenkins
bash
apt update
```
Install java :
```
apt install default-jdk
```
Install Jenkins :

```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

Start / Enable :

```
systemctl start jenkins
systemctl enable jenkins
```
![Screenshot 2023-12-06 130925](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/0c22e8f0-3185-489c-aaa5-d3005d4b8847)

  
![Screenshot 2023-12-06 130948](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/ffcae410-15cf-46f8-b915-a3c5555d49f6)

For security purposes , enable firewall ufw and allow port 8080(jenkins) and OpenSSH
```
ufw enable
ufw allow 8080
ufw allow OpenSSH
```
![Screenshot 2023-12-06 131522](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/b91fcd28-732d-40d9-8ba2-f72d7faaa746)


![Screenshot 2023-12-06 131703](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/d7babe06-c2d6-4937-9d61-328179449da9)


###3- Set up Ansible Server :
