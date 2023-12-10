#Base image
FROM nginx:1.19.8-alpine

#Thông tin maintainer
LABEL maintainer="NguyenQuyen <nguyenquyen18011996@gmail.com>"

#Kiểm tra alpine & nginx version
RUN cat /etc/os-release | grep PRETTY_NAME && nginx -v

#Định nghĩa biến
ARG TZ=UTC

#Thiết lập biến môi trường
ENV TZ=$TZ \
	COMPOSER_ALLOW_SUPERUSER=1

#Cập nhật timezone với biến môi trường đã định nghĩa ở trên
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && date

#Xóa config default nginx
RUN rm /etc/nginx/conf.d/default.conf

#Thư mục làm việc
WORKDIR /var/www/html

#Khai báo port lắng nghe
EXPOSE 80 81 82 443

#Copy file command start vào container
COPY nginx/start /command/start

#Set permission file bash bên trong container
RUN ["chmod", "+x", "-R", "/command/start"]

# Run file command start được copy ở trên
ENTRYPOINT ["/command/start"]
