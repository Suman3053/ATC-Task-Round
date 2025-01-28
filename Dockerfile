FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
