# Terraform Web application.

Project Description:

Deploying web application in AWS cloud environment , using Terraform and Ansible.

I used Terraform to deploy and configure the AWS services and ifrastructure, and used Ansible to install and configure the instance dependencies.

The biggest challenge I faced was making my project fully automated.
Deployment sequence played a big role here , having some services wait for other services to come up before getting deployed themselves.

Prerequisites:
- Make sure you have the latest version of Terraform and Ansible.
- AWS CLI

Installation:
1. Pull my repository.
2. Configure your aws environment.
3. Change the AZs inside the vpc.tf file
4. Deploy with Terraform.

Validation:
- Open a browser tab and insert : <EC2-instance-public-ip>/Web/index.html

Credits:
Ankush Chavan, I learned alot from his deployment .
