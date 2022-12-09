# Opensearch

Module to provision opensearch and using the opensearch api create a basic index and index policy

### To update s3 archive lambda.

Ensure you have the following packages installed:

- python3
- pip3
- openssl

From the module directory run the following to install new dependencies and update the deployable zip artifact

```shell
$ ./scripts/update_lambda.sh
```

Once you have created the artifact you will need to upload it s3 using the following script

```shell
$ARTIFACT_BUCKET=xxx aws-vault exec your-shared-credentials -- ./scripts/upload_to_s3.sh
```

`$ARTIFACT_BUCKET` will be one of the following

- pathtolive-ci-codebuild
- sandbox-ci-codebuild
