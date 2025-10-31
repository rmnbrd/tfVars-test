# Terraform tfvars test project

This project creates a simple S3 bucket with a randomized name using Terraform. It also includes multiple `.tfvars` scenarios:

- Single `.tfvars` file
- Two `.tfvars` files split across base + overrides
- Common `.tfvars` shared file combined with per-environment overrides

## Prerequisites

- Terraform >= 1.4
- AWS credentials available in your environment (e.g., `AWS_PROFILE`, `AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY`)

## Project layout

```
versions.tf
providers.tf
variables.tf
main.tf
outputs.tf
scenarios/
  single-file/
    terraform.tfvars
  two-files/
    base.tfvars
    overrides.tfvars
  common-and-overrides/
    common.tfvars
    env_a.tfvars
    env_b.tfvars
```

## What it creates

- One S3 bucket with name = `${var.bucket_prefix}-${random_id}`
- Optional versioning
- Optional force destroy

## Usage

From the project root (`/Users/romainbillard/code/tfVars-test`):

Initialize once:

```bash
terraform init
```

### Scenario 1: single .tfvars file

```bash
terraform apply -var-file=scenarios/single-file/terraform.tfvars
```

### Scenario 2: two .tfvars files (base + overrides)

Terraform applies files in the order provided; later files override earlier ones.

```bash
terraform apply \
  -var-file=scenarios/two-files/base.tfvars \
  -var-file=scenarios/two-files/overrides.tfvars
```

### Scenario 3: common + per-env overrides

Pick one env and combine it with the shared common file.

```bash
# Env A
terraform apply \
  -var-file=scenarios/common-and-overrides/common.tfvars \
  -var-file=scenarios/common-and-overrides/env_a.tfvars

# Env B
terraform apply \
  -var-file=scenarios/common-and-overrides/common.tfvars \
  -var-file=scenarios/common-and-overrides/env_b.tfvars
```

## Destroy

Use the same var-file(s) combination used for apply:

```bash
terraform destroy -var-file=... [-var-file=...]
```

## Notes

- Bucket names must be globally unique and lowercase. A random hex suffix is appended automatically.
- `force_destroy = true` allows destroying non-empty buckets; set to false in production.
