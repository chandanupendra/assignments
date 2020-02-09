

Q.2 Create a deployment to run nginx on kubernetes and application should be accessible from the internet.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


    --It contains both Deployment and Service specification in the same file.
    
    --The nginx server serves HTTP traffic on port 80 and HTTPS traffic on 443, and nginx Service exposes both ports.
    
    --Each container has access to the keys through a volume mounted at /etc/nginx/ssl. This is setup before the nginx server         is started.


--------------------------------------------------

kubectl create configmap nginxconfigmap --from-file=default.conf

kubectl create secret tls nginxsecret --key /tmp/nginx.key --cert /tmp/nginx.crt
kubectl apply -f nginxsecrets.yaml

kubectl create -f ./nginx_deployment_service.yaml

--------------------------------------------------
// change service from nodeport to loadbalancer @aws

  kubectl edit svc my-nginx

  -- updated type: NodePort >> type: LoadBalancer 

 *this will create a loadbalancer to access the nginx service from internet @aws.
