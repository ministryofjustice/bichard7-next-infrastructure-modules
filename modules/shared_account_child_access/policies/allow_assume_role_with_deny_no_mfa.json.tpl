{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${parent_account_id}:${arn_suffix}"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "ArnNotEquals" : {
          "aws:PrincipalArn" : ${excluded_arns}
        },
        "StringEquals" : {
          "aws:PrincipalTag/user-role": "${user_role}"
        }
      }
    }
  ]
}
