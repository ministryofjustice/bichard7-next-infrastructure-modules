.PHONY: terraform-init
terraform-init:
	./scripts/init_terraform.py modules

.PHONY: terraform-clean-all
terraform-clean-all:
	bash -c "find . -name .terraform -type d | xargs rm -rf"
	bash -c "find . -name .terraform.lock.hcl -type f | xargs rm -rf"
