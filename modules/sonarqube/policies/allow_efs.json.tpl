{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowEFSAccess",
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:ClientMount",
        "elasticfilesystem:DescribeAccessPoints",
        "elasticfilesystem:ClientWrite",
        "elasticfilesystem:ClientRootAccess",
        "elasticfilesystem:DescribeFileSystems"
      ],
      "Resource": [
        "arn:aws:elasticfilesystem:${region}:${account_id}:file-system/${file_system_id}",
        "arn:aws:elasticfilesystem:${region}:${account_id}:access-point/*"
      ]
    }
  ]
}
