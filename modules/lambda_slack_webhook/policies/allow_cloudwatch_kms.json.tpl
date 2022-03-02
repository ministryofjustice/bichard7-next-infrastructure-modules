{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "Enable IAM User Permissions",
        "Effect": "Allow",
        "Principal": {
            "AWS": [
              "arn:aws:iam::${account_id}:root",
              "arn:aws:iam::${account_id}:role/Bichard7-CI-Access"
            ]
        },
        "Action": "kms:*",
        "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudwatch.amazonaws.com"
      },
      "Action": [
        "kms:GenerateDataKey*",
        "kms:Decrypt"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "sns.${region}.amazonaws.com"
        }
      }
    }
  ]
}
