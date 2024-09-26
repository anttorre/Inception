#!/bin/bash
# Copiar el archivo index.static.html a /var/www/html después de que se haya montado el volumen
cp /index.static.html /var/www/html/

# Iniciar NGINX en modo foreground
nginx -g "daemon off;"
