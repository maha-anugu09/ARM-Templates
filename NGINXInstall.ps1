
sudo apt-get install nginx

# sudo vim /etc/nginx/nginx.conf
user  nginx;
worker_processes  2;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    access_log  /var/log/nginx/access.log  main;


    include /etc/nginx/sites-available/*.conf;
	http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       80;

		-- Change the localhost to the servername
        server_name  localhost;
        root  /nginx/html/organizr;

        index index.php index.html index.htm;       
	    error_page 400 401 403 404 405 408 500 502 503 504  /error.php?error=$status;
        location ~ \.php$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }

    }

}



