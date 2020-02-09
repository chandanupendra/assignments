

Q.2 Create a deployment to run nginx on kubernetes and application should be accessible from the internet.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
summary:

-- this is simple kubernetes nginx deployment and service

-- the provisioned service can be exposed publicly using ip,lb or domain.

-----------

my nginx test endpoint :
http://afbeafc7fa344425d8d73386a341a559-2131862725.ap-south-1.elb.amazonaws.com/


-------------------------------------------

// testing nginx service

[centos@ip-172-20-2-88 testnginx]$ kubectl create -f ./newtestnginx.yml
service/my-nginx created  
deployment.apps/my-nginx created  
[centos@ip-172-20-2-88 testnginx]$



[centos@ip-172-20-2-88 testnginx]$ kubectl get all -l run=my-nginx
NAME                            READY   STATUS    RESTARTS   AGE
pod/my-nginx-756fb87568-94nsj   1/1     Running   0          33s
pod/my-nginx-756fb87568-kqs5q   1/1     Running   0          33s

NAME               TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/my-nginx   NodePort   100.69.150.90   <none>        80:32066/TCP   33s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/my-nginx-756fb87568   2         2         2       33s
[centos@ip-172-20-2-88 testnginx]$


---------------------------
[centos@ip-172-20-2-88 testnginx]$ kubectl get ep -l run=my-nginx
NAME       ENDPOINTS                       AGE
my-nginx   100.108.0.5:80,100.116.0.4:80   93s
[centos@ip-172-20-2-88 testnginx]$


from master node :
admin@ip-172-20-32-15:~$ curl  http://100.108.0.5:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
admin@ip-172-20-32-15:~$


// from master node :

admin@ip-172-20-32-15:~$ curl http://172.20.32.15:32066
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
admin@ip-172-20-32-15:~$

note : nginx services can be accessed using public ip , check if the master node has public ip assigned.

-----------------------------------------------------------
// In my case, all kubernetes nodes were provisioned in private subnets, so updated my service to 'type: LoadBalancer'

[centos@ip-172-20-2-88 testnginx]$ kubectl get svc my-nginx  
NAME       TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
my-nginx   NodePort   100.69.150.90   <none>        80:32066/TCP   6m31s
[centos@ip-172-20-2-88 testnginx]$ kubectl edit svc my-nginx  
service/my-nginx edited
[centos@ip-172-20-2-88 testnginx]$ kubectl get svc my-nginx  
NAME       TYPE           CLUSTER-IP      EXTERNAL-IP                                                                PORT(S)        AGE
my-nginx   LoadBalancer   100.69.150.90   afbeafc7fa344425d8d73386a341a559-2131862725.ap-south-1.elb.amazonaws.com   80:32066/TCP   7m37s
[centos@ip-172-20-2-88 testnginx]$ 

-----------------------------------------------------------

// nginx can be accessed publicly using below lb url , also domain mapping can be done further. 
http://afbeafc7fa344425d8d73386a341a559-2131862725.ap-south-1.elb.amazonaws.com/  
