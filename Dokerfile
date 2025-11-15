# 1. Substitua o Dockerfile atual por este mais simples:
cat > Dockerfile << 'EOF'
FROM nginx:alpine

# Configuração inline do nginx
RUN rm -rf /etc/nginx/conf.d/* && \
    echo 'server { \
        listen 80; \
        server_name _; \
        root /usr/share/nginx/html; \
        index index.html; \
        location / { \
            try_files $uri $uri/ /index.html; \
            add_header Cache-Control "no-cache"; \
            add_header Access-Control-Allow-Origin "*"; \
        } \
    }' > /etc/nginx/conf.d/default.conf

# Copiar HTML
COPY index.html /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# 2. Commit e push
git add Dockerfile
git commit -m "Simplify Dockerfile - fix deployment"
git push origin main
