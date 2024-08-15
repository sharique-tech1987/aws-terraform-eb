
# Dockerized React App on Elastic BeanStalk

## This project automates deploying a Dockerized React app to AWS Elastic Beanstalk using Terraform and GitHub Actions.

This sample project demonstrates the end-to-end automation of deploying a Dockerized React app to AWS Elastic Beanstalk. Using Terraform, it creates and uploads a code zip file to an S3 bucket, sets up an Elastic Beanstalk environment, and deploys the application version. GitHub Actions is integrated for continuous deployment, ensuring automatic updates to the Elastic Beanstalk environment when code changes occur. Thanks to [Muhammed Ali](https://khabdrick-dev.medium.com/) for the react app code. This example guides you through performing the following actions:

* Develop a React application.
* Create a Dockerfile for the React application.
* Use Terraform to package the React application into a zip file.
* Utilize Terraform to provision an S3 bucket and upload the zip file.
* Define an application version using Terraform.
* Set up an Elastic Beanstalk environment and configure it with the specified application version.
* Create an instance profile and associate it with EC2 instances.
* Implement continuous deployment of the Dockerized React application to Elastic Beanstalk using GitHub Actions.

## Infrastructure Diagram
![Infrastructure Diagram](./infra_diagram.png)


## How to use this example project
* Setup AWS CLI.
* Generate keys on AWS to use with AWS CLI.
* Setup AWS keys for CI/CD.
* Install terraform.

### Setup AWS keys for CI/CD
* Create a user with __AdministratorAccess-AWSElasticBeanstalk__ and __AWSElasticBeanstalkReadOnly__ permission.
* Generate keys with the option "Application running on an AWS compute service"
* Put the keys under Settings > Secrets and variables > Actions > repository secrets in github.

Run these commands from the root directory of the project
```bash
cd infra
terraform init
terraform validate
terraform plan
terraform apply
```


## Find a bug
If you encounter an issue or have suggestions for improving this project, please submit an issue via the "Issues" tab above.

## Author

[Sharique Ali](https://github.com/sharique-tech1987)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Profile-blue)](https://www.linkedin.com/in/sharique-khan-99934028)

