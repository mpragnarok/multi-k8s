# Build images with latest and $SHA tag
docker build -t mpragarok/multi-client:latest -t mpragarok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mpragarok/multi-server:latest mpragarok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mpragarok/multi-worker:latest mpragarok/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push built images
docker push mpragarok/multi-client:latest
docker push mpragarok/multi-server:latest
docker push mpragarok/multi-worker:latest

docker push mpragarok/multi-client:$SHA
docker push mpragarok/multi-server:$SHA
docker push mpragarok/multi-worker:$SHA
# Apply kubectl config
kubectl apply -f k8s
# Set the image with $SHA tag
kubectl set image deployments/server-deployment server=mpragarok/multi-server:$SHA
kubectl set image deployments/client-deployment client=mpragarok/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mpragarok/multi-worker:$SHA