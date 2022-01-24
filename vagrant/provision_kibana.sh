# Install aditional tools
sudo yum install -y wget
sudo yum install -y net-tools

# Install kibana
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

sudo tee /etc/yum.repos.d/elasticsearch.repo > /dev/null <<'EOF'
[kibana-6.x]
name=Kibana repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

sudo yum install -y kibana

# Copy config files
sudo cp /vagrant/kibana.yml /etc/kibana/kibana.yml

# Enable and start the service
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service
sudo systemctl status kibana.service