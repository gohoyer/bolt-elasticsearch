sudo cp /vagrant/hosts /etc/hosts
sudo cp /vagrant/limits.conf /etc/security/limits.conf
sudo cp /vagrant/sysctl.conf /etc/sysctl.conf
sudo sysctl -p

sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo setenforce 0