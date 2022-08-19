resource "aws_securityhub_account" "jazz_securityhub" {}

resource "aws_securityhub_standards_subscription" "jazz_securityhub_foundationbenchmark" {
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
  depends_on    = [aws_securityhub_account.jazz_securityhub]
}

resource "aws_securityhub_standards_subscription" "jazz_securityhub_bestpractice" {
  standards_arn = "arn:aws:securityhub:us-east-1::standards/aws-foundational-security-best-practices/v/1.0.0"
  depends_on    = [aws_securityhub_account.jazz_securityhub]
}