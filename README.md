# liveword

## How?

### Requirements

Steps for Ubuntu 20:

 - Install Terraform

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
```
 - Install Hugo

```bash
sudo apt install hugo
```

Make Hover account. Buy domain. Make DigitalOcean account. Edit nameserver info in Hover to DigitalOcean nameserver urls.

Generate DigitalOcean API token. Create terraform.tfvars this as do_token.

```bash
terraform init
terraform apply -auto-approve
```
