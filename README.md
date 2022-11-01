# Terraform Web application.

Project Description:

Deploying web application in AWS cloud environment, using Terraform and Ansible.

I used Terraform to deploy and configure the AWS services and infrastructure and used Ansible to install and configure the instance dependencies.

The biggest challenge I faced was making my project fully automated.
Deployment sequence played a big role here, having some services wait for other services to come up before getting deployed themselves.

Prerequisites:
- Make sure you have the latest version of Terraform and Ansible.
- AWS CLI

Installation:
1. Clone my repository :
- git clone https://github.com/SrHammerlock/webapp.git

2. Configure your AWS environment:
- AWS configure ( input your access key, secret key and region)
- copy the credentials into "~/.aws/credentials"
3. Change the subnet AZs inside the vpc.tf file to your AZs.
4. Deploy with Terraform:
- Terraform init
- Terraform plan
- Terraform apply

Validation:
- Open a browser tab and insert: Your-EC2-instance-public-ip/Web/index.html

Credits:
Ankush Chavan, I learned a lot from his deployment.

References:
- Terraform installation: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Ansible installation: https://docs.ansible.com/ansible/2.3/intro_installation.html#installation
- AWS CLI installation: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
