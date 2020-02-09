Q.1 Create a deployment to deploy jenkins on kubernetes? Make sure to attach pvc (persistent volume claim).


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


git clone https://github.com/chandanupendra/assignments.git

cd Question_1;
kubectl create ns ns-jenkins
kubectl create -f .

kubectl get all -n=ns-jenkins

------------------------------------------------------------------
