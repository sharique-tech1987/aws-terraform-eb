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

variable "code_dist" {
    default = "code"
}

variable "code_dist_version" {
    default = "1.0"
}