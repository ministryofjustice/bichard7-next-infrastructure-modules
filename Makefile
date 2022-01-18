.PHONY: terraform-init
terraform-init:
	./scripts/init_terraform.py modules

.PHONY: terraform-clean-all
terraform-clean-all:
	bash -c "find . -name .terraform -type d | xargs rm -rf"
	bash -c "find . -name .terraform.lock.hcl -type f | xargs rm -rf"

.PHONY: terraform-validate
terraform-validate: terraform-init
	{ \
    set -e ; \
  	for dir in ./modules/*/; \
		do \
		 echo "Validating terraform in $${dir}"; \
		 cd "$${dir}"; \
		 AWS_REGION=placeholder-region-name terraform validate; \
		 cd ../../; \
	 	done \
	}
