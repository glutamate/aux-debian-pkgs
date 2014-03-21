cibuild: nginx-bucket inotify

citest:

nginx-bucket:
	rm -rf /tmp/nginx-bucket-64
	mkdir -p /tmp/nginx-bucket-64
	echo 'server_names_hash_bucket_size 64;\n' \
	  >/tmp/nginx-bucket-64/server_names_hash_bucket_size.conf
	cd /tmp/nginx-bucket-64 && \
	  fpm -s dir -t deb -n nginx-bucket-64 -v 0.1 --prefix /etc/nginx/conf.d/ .
	cd /srv/reprepro/ubuntu && \
          reprepro includedeb openbrain /tmp/nginx-bucket-64/nginx-bucket-64_0.1_amd64.deb

