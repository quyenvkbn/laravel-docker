#Base image
FROM redis:latest

#Thông tin maintainer
LABEL maintainer="NguyenQuyen <nguyenquyen18011996@gmail.com>"

#Tạo thư mục nếu thư mục đó không tồn tại
RUN mkdir -p /usr/local/etc/redis

#Copy file config từ local vào container
COPY redis/redis.conf /usr/local/etc/redis/redis.conf

# Tạo thư mục /data vào container và mount với thư mục ở host
VOLUME /data

#Khai báo port lắng nghe
EXPOSE 6379

#Run redis server với file config
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]