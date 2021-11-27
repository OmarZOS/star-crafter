
#This Work was done by HENTOUS Islam and ZAIDI Omar contributed to it..

docker stop server1 server2 load-balancer 
docker rm server1 server2 load-balancer
docker run --name server1 --mount type=bind,source=$(pwd)/server1,target=/usr/share/nginx/html,readonly  -p 8080:80 -d nginx
docker run --name server2 --mount type=bind,source=$(pwd)/server2,target=/usr/share/nginx/html,readonly  -p 8081:80 -d nginx
docker build -t nginx-load-balancer $(pwd)/proxy
docker run --name load-balancer -p 8082:80 -d nginx-load-balancer
