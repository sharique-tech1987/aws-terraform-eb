# create S3 bucket to store code
resource "aws_s3_bucket" "code_bucket" {
  bucket = "code-dist-elb-dist"
}

resource "aws_s3_object" "dist_item" {
  key    = "dist-${basename("${var.code_dist}-${var.code_dist_version}")}.zip"
  bucket = "${aws_s3_bucket.code_bucket.id}"
  source = data.archive_file.code_dist_zip.output_path
}


# Create IAM role EB instances
resource "aws_iam_role" "sfs_bean_role" {
  name               = "sfs-bean-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkCustomPlatformforEC2Role",
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkRoleSNS",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
  ]

  tags = {
    Project = "EB Docker React"
  }

}

# Create Instance Profile from sfs_bean_role

resource "aws_iam_instance_profile" "sfs_instance_profile" {
  name = "sfs-bean-role"
  role = aws_iam_role.sfs_bean_role.name

  tags = {
    Project = "EB Docker React"
  }
}

# Create elastic beanstalk application
 
resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.elasticapp
}

# Create elastic beanstalk application version
resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.code_dist}${var.code_dist_version}"
  application = aws_elastic_beanstalk_application.elasticapp.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.code_bucket.id
  key         = aws_s3_object.dist_item.id
}
 
# Create elastic beanstalk Environment
 
resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = var.beanstalkappenv
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = var.solution_stack_name
  # Needs to be set if we use aws_elastic_beanstalk_application_version resource
  version_label = aws_elastic_beanstalk_application_version.default.name
 
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  aws_iam_instance_profile.sfs_instance_profile.name
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }
 
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [for s in data.aws_subnet.default_subnets : s.id])
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
 
}