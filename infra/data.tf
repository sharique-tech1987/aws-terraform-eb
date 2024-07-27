data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# create a zip for deployment with terraform
data "archive_file" "code_dist_zip"{
    type = "zip"
    source_dir = "../${path.module}/${var.code_dist}"
    output_path = "../${path.module}/${var.code_dist}${var.code_dist_version}.zip"
}