resource "aws_config_configuration_recorder" "jazz_config_configrec" {
  name     = "jazz-config-recorder"
  role_arn = aws_iam_role.config_iam_role.arn

}

resource "aws_iam_role" "config_iam_role" {
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : ["config.amazonaws.com"]
          },
          "Effect" : "Allow",
        }
      ]
    }
  )
}



resource "aws_config_config_rule" "jazz_configrule_ec2ebsencrypt" {
  name = "jazz-ec2-ebs-encryption"

  source {
    owner             = "AWS"
    source_identifier = "EC2_EBS_ENCRYPTION_BY_DEFAULT"
  }
  depends_on = [aws_config_configuration_recorder.jazz_config_configrec]

  tags = {
    Name        = "jazz_configrule_ec2ebsencrypt",
    Terraform   = "Yes",
    Environment = "Dev"
  }
}

resource "aws_config_config_rule" "jazz_configrule_requiredtags" {
  name = "jazz-required-tags"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = jsonencode({
    "tag1Key" : "Name",
    "tag2Key" : "Terraform",
    "tag3Key" : "Environment"
  })
  depends_on = [aws_config_configuration_recorder.jazz_config_configrec]

  tags = {
    Name        = "jazz_configrule_requiredtags",
    Terraform   = "Yes",
    Environment = "Dev"
  }
}


resource "aws_config_config_rule" "jazz_configrule_iamrotation" {
  name = "jazz-iam-key-rotation"

  source {
    owner             = "AWS"
    source_identifier = "ACCESS_KEYS_ROTATED"
  }

  input_parameters = jsonencode({ maxAccessKeyAge = "45" })
  depends_on       = [aws_config_configuration_recorder.jazz_config_configrec]

  tags = {
    Name        = "jazz_configrule_iamrotation",
    Terraform   = "Yes",
    Environment = "Dev"
  }
}
