  #!/bin/bash
  sudo su -
  wget https://github.com/prometheus/prometheus/releases/download/v2.39.1/prometheus-2.39.1.linux-amd64.tar.gz
  tar -xvzf prometheus-2.39.1.linux-amd64.tar.gz
  cd prometheus-2.39.1.linux-amd64/
  sed -i 's/localhost:9090/10.0.5.98:9100/' prometheus.yml
  ./prometheus

