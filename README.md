### Một số lưu ý
Máy tính hoặc server của bạn cần cài đặt docker, docker-compose

Mình có sử dụng trên window và ubuntu thì window có thể không run được file bash các bạn có thể fix như sau: window mình có sử dụng notepad++ để fix, mình mở file chọn [ Edit-> EOL conversion -> Unix (LF) ] sau đó lưu lại là xong.

Hiện tại mình có tạo thêm 1 branch có config domain and ssl. Nếu bạn muốn thử bạn có thể truy cập branch `SSL`, mình sử dụng Certbot create ssl nên bạn cần điền đúng thông tin `LETSENCRYPT_PATH_HOST` & `LETSENCRYPT_PATH_CONTAINER` trong file `.env` và sửa lại các thông tin domain, thông tin config ssl trong file config `/nginx/site/nginx-sites-api.conf`

Thông tin `CREATE_USER` trong file `.env` bạn cần lưu ý nếu giá trị setup là `true` bạn cần nhập đúng thông tin user id, group id host hoặc local của bạn. Vì user này sẽ là user run process, trường hợp `CREATE_USER` set là `false` sẽ sử dụng user root run process. Mình thường sẽ dung lệnh `id` xem thông tin này.
```
#Thông tin user id
id -u

#Thông tin group id
id -g
```

### Setup Test
```
#Create file .env by .env.example
cp .env.example .env

#Create file .env by .env.example trong thư mục code/api
cp code/api/.env.example code/api/.env

#Run product
docker-compose -f docker-compose.product.yaml up -d nginx redis

#Deploy api
sh deploy/api
```

### Test redis, db and queue work
```
#Test redis
SET TEST: /test/redis/set
GET TEST: /test/redis/get

#Test db
SET TEST: /test/db/set
GET TEST: /test/db/get

#Test queue
SET TEST: /test/queue/set
GET TEST: /test/queue/get
```

### Build & run dev
```
docker-compose up -d --force-recreate --build --no-deps --remove-orphans ${service}
OR
docker-compose up -d --force-recreate --build --no-deps --remove-orphans ${service} ${service} ...
```

### Push image Docker hub
```
docker image push ${image}
```

### Run product
```
docker-compose -f docker-compose.product.yaml up -d nginx redis
```

### Remove & start container (usually applied to the case of changing environment variables )
```
docker-compose -f docker-compose.product.yaml up -d --force-recreate nginx redis
```

### Deploy api
```
sh deploy/api
OR
docker exec -it php8.0-fpm sh /command/api
```