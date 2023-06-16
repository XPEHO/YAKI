#!/bin/sh

# Replace env vars in files served by NGINX
for file in usr/share/nginx/html/assets/*.js;
do 
  sed -i -e 's|URL_PLACEHOLDER|'${VUE3_URL}'|g' $file
done

  # Starting NGINX
nginx -g 'daemon off;'