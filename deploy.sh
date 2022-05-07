docker build -t phuongngo/my-multi-client:latest -t phuongngo/my-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phuongngo/my-multi-worker:latest -t phuongngo/my-multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t phuongngo/my-multi-server:latest -t phuongngo/my-multi-server:$SHA -f ./server/Dockerfile ./server

docker push phuongngo/my-multi-client:latest
docker push phuongngo/my-multi-worker:latest
docker push phuongngo/my-multi-server:latest

docker push phuongngo/my-multi-client:latest:$SHA
docker push phuongngo/my-multi-worker:latest:$SHA
docker push phuongngo/my-multi-server:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phuongngo/my-multi-server:$SHA
kubectl set image deployments/client-deployment client=phuongngo/my-multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phuongngo/my-multi-worker:$SHA