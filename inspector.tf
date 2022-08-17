# # Create an inspector resource group to target selected EC2 instances via tagging
# resource "aws_inspector_resource_group" "alvin_capstone_resource_group" {
#   tags = {
#     "Inspector Resource Group" = "Alvin"
#   }
# }

# # Create inspector assessment target to point towards inspector resource group
# # Inspector Classic Target Limits are capped at 50
# resource "aws_inspector_assessment_target" "alvin_capstone_assessment_target" {
#   name               = "Alvin Capstone Inspector Targets"
#   resource_group_arn = aws_inspector_resource_group.alvin_capstone_resource_group.arn
# }

# # Create Inspector Assessment Templates using rule package for 
# # Common vulnerabilities and exposures, CIS OS Security Config Benchmarks, 
# # Security Best Practices
# resource "aws_inspector_assessment_template" "alvin_capstone_assessment_template" {
#   name               = "Alvin Capstone Assessment Template"
#   duration           = 3600
#   rules_package_arns = []
#   target_arn         = aws_inspector_assessment_target.alvin_capstone_assessment_target.arn
# }