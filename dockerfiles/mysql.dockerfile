#Base image
FROM mysql:8.0

#Thông tin maintainer
LABEL maintainer="NguyenQuyen <nguyenquyen18011996@gmail.com>"

#Định nghĩa biến
ARG TZ=UTC

#Thiết lập biến môi trường
ENV TZ ${TZ}

#Cập nhật timezone với biến môi trường đã định nghĩa ở trên và set permission
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

#Khai báo port lắng nghe
EXPOSE 3306

#Run mysqld
CMD ["mysqld"]