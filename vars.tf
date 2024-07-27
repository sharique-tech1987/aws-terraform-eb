variable "REGION" {
  default = "us-east-1"
}

variable "elasticapp" {
  default = "DockerReactApp"
}
variable "beanstalkappenv" {
  default = "ReactEnvironment"
}
variable "solution_stack_name" {
  default = "64bit Amazon Linux 2023 v4.3.4 running Docker"
}
variable "tier" {
  default = "WebServer"
}
 
variable "vpc_id" {
    default = "vpc-0dcbc52a94b403e68"
}
variable "public_subnets" {
    default = ["subnet-06d7adbcb57108a81", 
                "subnet-01abebfb0a40f6835",
                "subnet-051a3a40f8d0793f6",
                "subnet-084b9e66e374c9a03",
                "subnet-0a0e7b30606ae27ce",
                "subnet-06713a285c37f58a5"]
}

variable "code_dist" {
    default = "code"
}

variable "code_dist_version" {
    default = "1.0"
}