{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowRepoAccess",
        "Effect": "Allow",
        "Action": [
          "ecr:DescribeImageScanFindings",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:ListTagsForResource",
          "ecr:ListImages",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetRepositoryPolicy",
          "ecr:GetAuthorizationToken",
          "ecr:GetLifecyclePolicy"
        ],
        "Resource": ${ecr_repos}
      },
      {
        "Sid": "AllowAuth",
        "Effect": "Allow",
        "Action": "ecr:GetAuthorizationToken",
        "Resource": "*"
      }
    ]
  }
