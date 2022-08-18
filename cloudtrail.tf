data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "jazz_s3_cloudtrail" {
  bucket        = "jazz-s3-cloudtrail"
  force_destroy = true
}
resource "aws_cloudtrail" "jazz_cloudtrail" {
  name                          = "jazz-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.jazz_s3_cloudtrail.bucket
  s3_key_prefix                 = "prefix"
  include_global_service_events = false

  depends_on = [aws_s3_bucket.jazz_s3_cloudtrail]
}


resource "aws_s3_bucket_policy" "jazz_s3_bucketpolicy" {
  bucket = aws_s3_bucket.jazz_s3_cloudtrail.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.jazz_s3_cloudtrail.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.jazz_s3_cloudtrail.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}