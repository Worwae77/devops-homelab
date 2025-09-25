# CI/CD AWS Credentials Integration

**Best Practice:** Store AWS credentials as CI/CD pipeline secrets, not in code or config files.

## GitHub Actions Example

Add these secrets in your repository settings:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_DEFAULT_REGION`

Reference them in your workflow YAML:

```yaml
jobs:
  terraform:
    runs-on: ubuntu-latest
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      AWS_DEFAULT_REGION: ${{ secrets.AWS_DEFAULT_REGION }}
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
      - name: Terraform Init
        run: terraform init
      - name: Terraform Apply
        run: terraform apply -auto-approve
```

## Jenkins Example

Use "Credentials Binding" plugin to inject secrets as environment variables for your pipeline steps.

---

Never commit credentials. Use your CI/CD system's secrets manager for all sensitive values.