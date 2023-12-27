terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "us-west"
}

# Variable Interpolation:
variable "region" {
  default = "us-west"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  availability_zone = "${var.region}a"
}

# Resource Attribute Interpolation:
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name
}

resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = "ssh-rsa ..."
}

# Output Value Interpolation:
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}

output "instance_id" {
  value = aws_instance.example.id
}

# Join Function:
variable "tags" {
  type    = list(string)
  default = ["tag1", "tag2", "tag3"]
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  tags          = join(", ", var.tags)
}

# Conditional Expression:
variable "environment" {
  type    = string
  default = "dev"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  count         = var.environment == "prod" ? 2 : 1
}
