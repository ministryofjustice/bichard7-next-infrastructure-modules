{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
          "ssm:PutParameter",
          "ssm:GetParameter",
          "ssm:GetParameters"
        ],
        "Resource": [
          "${sonar_db_password_arn}",
          "${sonar_db_user_arn}"
        ]
      }
    ]
  }
