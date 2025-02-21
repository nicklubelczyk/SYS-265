#secure-ssh.sh
#author
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in

USERNAME=$1
GITHUB="https://raw.githubusercontent.com/nicklubelczyk/SYS-265/refs/heads/main/SYS265/linux/public-keys/id_rsa.pub"

#Creates user using USERNAME
sudo useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME

#Creates the SSH directory
sudo mkdir /home/$USERNAME/.ssh

#Curl the public key
sudo curl -s "$GITHUB" -o /tmp/id_rsa.pub

#Copy the public key to the user's folder
sudo cp /tmp/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

#Remove the public key
sudo rm /tmp/id_rsa.pub

#Set permissions
sudo chmod 700 /home/$USERNAME/.ssh
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "The user $USERNAME has been configured for passwordless SSH login."
