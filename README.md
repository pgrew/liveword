How? Make Hover account. Buy domain. Make DigitalOcean account. Edit nameserver info in Hover to DigitalOcean nameserver urls.
Create a git repository
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
Generate DigitalOcean API token. Create terraform.tfvars this as .
Generate DigitalOcean API token. Create terraform.tfvars this as do_token.

terraform init
terraform apply -auto-approve

scp hugo generate files (args?)