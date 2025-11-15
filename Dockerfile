cat > Dockerfile << 'EOF'
FROM nginx:alpine


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

COPY index.html /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF
