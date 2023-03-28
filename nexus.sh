#!/bin/bash
yum install java-1.8.0-openjdk.x86_64 wget -y   
mkdir -p /opt/nexus/   
mkdir -p /tmp/nexus/                           
cd /tmp/nexus/
NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
wget $NEXUSURL -O nexus.tar.gz
EXTOUT=`tar xzvf nexus.tar.gz`
NEXUSDIR=`echo $EXTOUT | cut -d '/' -f1`
rm -rf /tmp/nexus/nexus.tar.gz
rsync -avzh /tmp/nexus/ /opt/nexus/
useradd nexus
chown -R nexus.nexus /opt/nexus 
cat <<EOT>> /etc/systemd/system/nexus.service
[Unit]                                                                          
Description=nexus service                                                       
After=network.target                                                            
                                                                  
[Service]                                                                       
Type=forking                                                                    
LimitNOFILE=65536                                                               
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start                                  
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop                                    
User=nexus                                                                      
Restart=on-abort                                                                
                                                                  
[Install]                                                                       
WantedBy=multi-user.target
EOT
echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc
systemctl daemon-reload
systemctl start nexus
systemctl enable nexus


(or)
    1  sudo apt update
    2  sudo apt install openjdk-8-jre-headless
    3  wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
    4  tar -zxvf latest-unix.tar.gz
    5  sudo mv /opt/nexus-3.30.1-01 /opt/nexus
    6  ll
    7  mv nexus-3.50.0-01/ nexus
    8  sudo adduser nexus
    9  cat /etc/sudoers.tmp
   10  cd nexus
   11  ll
   12  cd etc
   13  ll
   14  cd ..
   15  sudo visudo
   16  sudo chown -R nexus:nexus /opt/nexus
   17  sudo chown -R nexus:nexus /opt/nexus-3.50.0-01/
   18  sudo chown -R nexus:nexus /opt/sonatype-work
   19  sudo vi /opt/nexus/bin/nexus.rc
   20  echo "nexus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users
   21  SUDO echo "nexus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users
   22  sudo vi /etc/systemd/system/nexus.service
   23  systemctl enable nexus
   24  systemctl start nexus
   25  systemctl status nexus
   26  history
