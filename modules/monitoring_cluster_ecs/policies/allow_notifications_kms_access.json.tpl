{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:*Grant"
      ],
      "Resource": "${kms_key_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:List*"
      ],
      "Resource": "*"
    }
  ]
}
