  #!/bin/bash
  sudo yum -y update
  sudo yum -y install mariadb
  sudo yum -y install docker
  sudo systemctl start docker
  sudo usermod -aG docker ec2-user
  sudo docker container run -d -p 8080:80 academind/node-example-1