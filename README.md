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

Install Publish over SSH plugin in Jenkins

![Screenshot 2023-12-06 231557](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/6bb9f3a4-222c-4c62-aef7-5f46c30945f0)


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
passwd root
vi /etc/ssh/sshd_config
systemctl restart sshd
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

### 1- Add SSH servers to Jenkins:

![Screenshot 2023-12-06 231814](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/6ce6be88-ee45-4bb4-b5e3-32cd56c9f236)

![Screenshot 2023-12-06 231830](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/d11967dc-b1f6-4ec2-8b6a-251f5b259c6f)

![Screenshot 2023-12-06 231854](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/5e15efc3-8887-4a46-8adc-a1697acac574)

### 2- Create CI/CD Pipeline:

![Screenshot 2023-12-06 232329](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/c1292780-4d4b-44da-b02e-7e039ebea417)

### 3- Add Github repo to  Jenkins:

![Screenshot 2023-12-06 232438](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/b9047438-34b3-4f0c-8d77-9648b911b6a2)

### 4- Create a Webhook in your github :
To trigger Jenkins if something is modified in the repo

![Screenshot 2023-12-06 232829](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/08d573f5-9cb4-425b-b2eb-e97b6ccb25b8)

![Screenshot 2023-12-06 232844](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/329e957a-c455-470e-8ccd-9ed309ad3f0e)

### 5- Build Steps :

![Screenshot 2023-12-06 233055](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/f4e514dc-3530-4045-b913-7b14ed2e7842)

![Screenshot 2023-12-06 233115](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/addbf399-9683-46f1-ad35-2d56e95efc25)

![Screenshot 2023-12-06 233141](https://github.com/HoussamEDGE/CI-CD-pipeline---Docker-DockerHub-GitHub-Jenkins-Ansible/assets/99811097/a9c49dac-79bf-4462-8790-4ab1717c0071)

