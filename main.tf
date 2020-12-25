# resources for liveword site

# stored out of version control in terraform.tfvars file
variable "do_token" {}

variable "do_ssh_key_path" {
  default = "/home/michael/.ssh/do"
}

# specify provider
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 1.0"
    }
  }
}


# configure the DigitalOcean provider
provider "digitalocean" {
  token = var.do_token
}

# create digitalocean ssh key
resource "digitalocean_ssh_key" "do_key" {
  name       = "grace-rsa"
  public_key = file("${var.do_ssh_key_path}.pub")
}

# create Web Droplet
resource "digitalocean_droplet" "liveword" {
  image  = "ubuntu-18-04-x64"
  name   = "liveword"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.do_key.id]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.do_ssh_key_path)
    timeout     = "2m"
  }

  # do setup
  provisioner "remote-exec" {
    
    scripts = [
      "install.sh",
      "setup-nginx.sh",
    ]
  }
}

resource "digitalocean_domain" "liveword" {
  name       = "liveword.blog"
  ip_address = digitalocean_droplet.liveword.ipv4_address
}

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.liveword.name
  type   = "A"
  name   = "www"
  value  = digitalocean_droplet.liveword.ipv4_address
}

resource "digitalocean_record" "at" {
  domain = digitalocean_domain.liveword.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.liveword.ipv4_address
}
