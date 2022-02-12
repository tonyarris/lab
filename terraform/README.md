AWS EC2 Provisioning with Terraform
===

# Requirements:
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)

[Tutorial](https://learn.hashicorp.com/tutorials/terraform/aws-build)

# Summary
Ensure you have `terraform` and `aws` CLI installed, and add IAM an Access key to AWS with `aws configure`
 
Edit the contents of `main.tf` to suit your needs.

From within this folder, initiate terraform with `terraform init`

Provision the instance with `terraform apply`

Destroy the instance with `terraform destroy`

