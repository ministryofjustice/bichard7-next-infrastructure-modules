# Postfix VPC

Provisions a separate VPC with an ecs cluster that contains a number of postfix containers. This VPC is separate to the application
as we do not want the application itself to have any form of world egress so we connect to the postfix nlb via a locked down service endpoint.

The following ssm parameters are expected to exist in the deployed environment prior to creating the vpc and cluster

```shell
  /<ENVIRONMENT_NAME>/smtp/client_cert
  /<ENVIRONMENT_NAME>/smtp/cjse_root_cert
  /<ENVIRONMENT_NAME>/smtp/relay_user
  /<ENVIRONMENT_NAME>/smtp/relay_password
```

If this is deployed into a stack, this needs to be run after the infra is created but before the user_service is deployed as the user service will
consume the following ssm parameters created by this module.

```shell
  /<ENVIRONMENT_NAME>/smtp/postfix_user
  /<ENVIRONMENT_NAME>/smtp/postfix_password
```

The `postfix_ecs` variable is a map in the following format

```shell
{
  repository_url = "The url of the repository"
  image_hash     = "sha256 hash from repo"
  repository_arn = "The arn of the repository"
}

```
