# Create an inspector resource group to target selected EC2 instances via tagging
resource "aws_inspector_resource_group" "jazz_capstone_resource_group" {
  tags = {
    "Inspector Resource Group" = "jazz"
  }
}

# Create inspector assessment target to point towards inspector resource group
# Inspector Classic Target Limits are capped at 50
resource "aws_inspector_assessment_target" "jazz_capstone_assessment_target" {
  name               = "jazz Capstone Inspector Targets"
  resource_group_arn = aws_inspector_resource_group.jazz_capstone_resource_group.arn
}

# Create Inspector Assessment Templates using rule package for 
# Common vulnerabilities and exposures, CIS OS Security Config Benchmarks, 
# Security Best Practices
resource "aws_inspector_assessment_template" "jazz_capstone_assessment_template" {
  name               = "jazz Capstone Assessment Template"
  duration           = 3600
  rules_package_arns = ["arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gEjTy7T7"]
  target_arn         = aws_inspector_assessment_target.jazz_capstone_assessment_target.arn
}