{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObjectAcl",
        "s3:GetObject",
        "s3:ListBucketVersions",
        "s3:GetObjectVersionAcl",
        "s3:ListBucket",
        "s3:GetBucketPolicy",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "arn:aws:s3:::${bucket_name}/*",
        "arn:aws:s3:::${bucket_name}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:DeleteObject",
        "s3:GetBucketLocation",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Resource": [
        "arn:aws:s3:::${bucket_name}/help/*",
        "arn:aws:s3:::${bucket_name}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "*"
    }
  ]
}
