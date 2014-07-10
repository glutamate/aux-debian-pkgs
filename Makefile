now   := $(shell date +%Y%m%d%H%M)

cibuild: nginx-bucket inotify-extra limesurveypkg

citest:

nginx-bucket:
	rm -rf /tmp/nginx-bucket-64
	mkdir -p /tmp/nginx-bucket-64
	echo 'server_names_hash_bucket_size 64;\n' \
	  >/tmp/nginx-bucket-64/server_names_hash_bucket_size.conf
	cd /tmp/nginx-bucket-64 && \
	  fpm -s dir -t deb -n nginx-bucket-64 -v 0.1 --prefix /etc/nginx/conf.d/ .
	-cd /srv/reprepro/ubuntu && \
          reprepro includedeb openbrain /tmp/nginx-bucket-64/nginx-bucket-64_0.1_amd64.deb

inotify-extra:
	rm -rf /tmp/inotify-extra
	mkdir -p /tmp/inotify-extra
	cp inotify/* /tmp/inotify-extra/
	chmod +x /tmp/inotify-extra/*
	cd /tmp/inotify-extra && \
	  fpm -s dir -t deb -d inotify-tools -n inotify-extra -v 0.1.1 --prefix /usr/bin/ .
	-cd /srv/reprepro/ubuntu && \
          reprepro includedeb openbrain /tmp/inotify-extra/inotify-extra_0.1_amd64.deb

limesurveypkg: 
	./build-limesurvey.sh
	-cd /srv/reprepro/ubuntu && \
          reprepro includedeb openbrain /tmp/lime_install_root/limesurvey_2.05.0.1_amd64.deb
