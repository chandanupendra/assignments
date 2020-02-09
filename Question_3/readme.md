

Q.3 Create a terraform template to deploy ec2 instance with a new security group. 
    All variable values should pass during run time as user parameters.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// Install terraform : v 0.11

wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip
sudo unzip ./terraform_0.11.0_linux_amd64.zip -d /usr/local/bin/

---------------------------------------------------
// clone repo and test the terraform template

git clone https://github.com/chandanupendra/assignments.git
cd Question_3 

note :
the required ec2 IAM role will be required to run this terraform template.
Or
the access_key and secret_key required to be updated in template 'ec2_terraform_template.tf'. 


---------------------------------------------------
// Variables provided as command line arguments :

$ terraform apply \
-var region='ap-south-1' \
-var ami='ami-0d11056c10bfdde69' \
-var instance_type='t3a.micro' \
-var ec2_name='test-instance-tf' \
-var ec2_az='ap-south-1a' \
-var sg_name='test-instance-tf-sg'


---------------------------------------------------
// Varibles from terraform variable file reference :
To persist variable values, created a file named terraform.tfvars

file : testing.tfvars
region="ap-south-1"
ami="ami-0d11056c10bfdde69"
instance_type="t3a.medium"
ec2_name='test-instance-tfvar'
ec2_az='ap-south-1b'
sg_name='test-instance-tfvar-sg'

$ terraform apply -var-file='testing.tfvars'


---------------------------------------------------
logs reference : test perfomed @aws 
terraform ec2 and security group provisioning
ref. logs : https://paste.ubuntu.com/p/fYHcZN35vm/

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
