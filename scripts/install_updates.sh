#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

function warn {
	echo "RUNNING: \"$@\""
	if ! eval "$@"; then
		echo >&2 "WARNING: command failed \"$@\""
	fi
}

sudo uname -a
sudo lsb_release -a
sudo df -h
sudo lsblk
sudo cat /etc/apt/sources.list

echo "Install ansible2"
warn "sudo apt-get update -y"
warn "sudo apt-get install -y ansible tcpd"
warn "sudo apt-get upgrade -y"

echo "Install other tools"


echo 'Downloading and installing SSM Agent' 
warn "sudo snap install amazon-ssm-agent --classic"

echo 'Downloading and installing amazon-cloudwatch-agent'
warn "wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb -O /var/tmp/amazon-cloudwatch-agent.deb"
warn "sudo apt-get install -y /var/tmp/amazon-cloudwatch-agent.deb"

echo 'Starting cloudwatch agent'
warn "sudo amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/tmp/CWAgentParameters.json -s"

# echo 'Install Amazon Inspector'
# warn 'curl https://inspector-agent.amazonaws.com/linux/latest/install | sudo bash'

## Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install fontconfig openjdk-11-jre -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins 
sudo apt-get install apt-utils -y
sudo apt install docker.io -y
sudo snap install docker
sudo service docker restart
sudo chmod 777 /var/run/docker.sock
sudo chmod -R 777 /var/lib/jenkins

