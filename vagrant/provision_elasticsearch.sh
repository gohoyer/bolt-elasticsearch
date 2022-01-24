# Install aditional tools
sudo yum install -y wget
sudo yum install -y net-tools


# Instal elasticsearch and java
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

sudo tee /etc/yum.repos.d/elasticsearch.repo > /dev/null <<'EOF'
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

sudo yum install -y java-1.8.0-openjdk
sudo yum install -y elasticsearch

# Copy config files
sudo cp /vagrant/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo cp /vagrant/jvm.options /etc/elasticsearch/jvm.options


# Enable and start the service
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch.service

