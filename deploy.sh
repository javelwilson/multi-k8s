docker build -t javelwilson/multi-client:latest -t javelwilson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t javelwilson/multi-server:latest -t javelwilson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t javelwilson/multi-worker:latest -t javelwilson/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push javelwilson/multi-client:latest
docker push javelwilson/multi-server:latest
docker push javelwilson/multi-worker:latest

docker push javelwilson/multi-client:$SHA
docker push javelwilson/multi-server:$SHA
docker push javelwilson/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=javelwilson/multi-server:$SHA
kubectl set image deployments/client-deployment client=javelwilson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=javelwilson/multi-worker:$SHA
