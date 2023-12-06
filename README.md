# CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible

## I- Set up environnement :
### 1 - Create 4 VM s (EC2 instances) in AWS :
while creating the instances assign to them a key pair that you have created , in my case its ubuntu-key , its a private key generated with RSA algorithm which is an asymmetric cryptography algorithm since its based on 2 keys (private/public) used for encryption and decryption .

![Screenshot 2023-12-05 085322](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/3b79a9f5-9b79-4411-aca7-fc70e58d1b4b)


![Screenshot 2023-12-06 111239](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/77722d41-6394-4dd1-b974-38904aee6e7c)

to connect using ssh with EC2 instance : 

ssh -i ubuntu-key.pem ubuntu@publicIPaddofinstance

### 2- Set up Jenkins Server :

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

### 3- Set up Ansible Server :

```
apt update
```

Install Ansible
```
apt-add-repository ppa:ansible/ansible
apt update
apt install ansible
```

Install Docker
```
apt install docker -y
apt install docker.io -y
```

![Screenshot 2023-12-06 163304](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/e854494d-74d8-4b7e-ad7d-41c34e8e2d7e)

Install Docker
```
apt install docker -y
apt install docker.io -y
systemctl enable docker
```
Add hosts to ansible
```
vi /etc/ansible/hosts
```
![Screenshot 2023-12-06 163906](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/f2d4e38c-16ff-45b8-af99-24d780c4609d)

Write your Playbook
```
mkdir /sourcecode
cd /sourcecode
vi docker.yml
```
![Screenshot 2023-12-06 164323](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/ecbdf7aa-db2d-4f85-96ed-85b18fcd3e3e)

### 4- Set up Docker Host Server :

Install Docker
```
apt update
apt install docker -y
apt install docker.io -y
systemctl enable docker
```
![Screenshot 2023-12-06 164530](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/d77279fc-fcc3-4ad7-b71c-2454e0d16e3f)

### 5- SSH Configuration:

In all 3 Servers configure permissions
```
vi /etc/ssh/sshd_config
```

![Screenshot 2023-12-06 164920](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/9cde44f0-5afe-4686-8ed3-07f6a8a8ee9e)

![Screenshot 2023-12-06 164941](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/4982df07-5323-4905-9eaa-28661bfde986)

In Jenkins Server
```
ssh-keygen
ssh-copy-id root@privateIPaddofAnsibleServer
```
In Ansibler Server
```
ssh-keygen
ssh-copy-id root@privateIPaddofDockerHostServer
```

## II- Create CI/CD pipeline :






