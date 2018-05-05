########################################################################
# ESDA AMI configuration file
# Execute this script inside the ami folder.
# scp -ri <KEY> <PATH/education/courses/ilt/ElasticStackDataAdministration/ami> ubuntu@<AMI>:
# ami, datasets, instructions, scripts
#######################################################################


# NGINX script configuration
# http://nginx.org/en/linux_packages.html#stable
# https://www.nginx.com/blog/introduction-nginscript/

# Setting nginx for Ubuntu "xenial"
wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
sudo sh -c 'echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list'

sudo apt-get -y update
sudo apt-get -y upgrade

# MySQL
#sudo apt-get -y remove mysql-server
#sudo apt-get -y autoremove
#sudo dpkg --purge `dpkg --get-selections | grep deinstall | cut -f1`
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-16-04
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
sudo mysql -uroot -e "CREATE USER ubuntu@localhost IDENTIFIED BY 'elastic';"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'localhost';"
sudo mysql -uroot -e "FLUSH PRIVILEGES;"
sudo mysql -uubuntu -pelastic < /home/ubuntu/ami/mysql/employees.sql

# Nginx
# Setup nginx loop functions
# http://nginx.org/en/docs/http/ngx_http_js_module.html
# Enable nginx stub status
# http://nginx.org/en/docs/ngx_core_module.html#worker_processes
# https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-16-04
sudo apt-get -y install nginx
sudo apt-get -y install nginx-module-njs
sudo systemctl unmask nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo cp nginx_config/nginx.conf /etc/nginx/
sudo cp nginx_config/load_functions.js /etc/nginx/conf.d/
sudo cp nginx_config/default.conf /etc/nginx/conf.d/
sudo cp nginx_config/index.html /usr/share/nginx/html/
sudo cp nginx_config/404.html /usr/share/nginx/html/
sudo nginx -s reload

# Others (vimrc)
sudo cp vimrc /etc/vim/vimrc

# JDBC library driver
wget http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.44/mysql-connector-java-5.1.44.jar

# Elastic
BASE_URL="https://artifacts.elastic.co/downloads"
VERSION="6.0.0-rc1"
SYSTEM="linux-x86_64"
wget $BASE_URL/beats/heartbeat/heartbeat-$VERSION-$SYSTEM.tar.gz
wget $BASE_URL/elasticsearch/elasticsearch-$VERSION.tar.gz
wget $BASE_URL/kibana/kibana-$VERSION-$SYSTEM.tar.gz
wget $BASE_URL/logstash/logstash-$VERSION.tar.gz
wget $BASE_URL/beats/metricbeat/metricbeat-$VERSION-$SYSTEM.tar.gz
wget $BASE_URL/beats/filebeat/filebeat-$VERSION-$SYSTEM.tar.gz
wget $BASE_URL/beats/packetbeat/packetbeat-$VERSION-$SYSTEM.tar.gz

for PRODUCT in heartbeat metricbeat filebeat packetbeat kibana elasticsearch logstash
do
  tar -zxf $PRODUCT-*
  mv $PRODUCT-*/ ../$PRODUCT
done
