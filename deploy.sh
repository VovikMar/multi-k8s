docker build -t vovikdevop/multi-client:latest -t vovikdevop/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vovikdevop/multi-server:latest -t vovikdevop/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vovikdevop/milti-worker:latest -t vovikdevop/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vovikdevop/multi-client:latest
docker push vovikdevop/multi-server:latest
docker push vovikdevop/multi-worker:latest

docker push vovikdevop/multi-client:$SHA
docker push vovikdevop/multi-server:$SHA
docker push vovikdevop/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vovikdevop/multi-server:$SHA
kubectl set image deployments/client-deployment client=vovikdevop/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vovikdevop/milti-worker:$SHA