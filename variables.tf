variable "project-tag" {
  type = string
  description = "The tag I want applied to every resource tracking it to this project"
  default = "dan-tf-vault-demo"
}

variable "vault-port" {
  type = int
  description = "The UI port for Vault communication"
  default = 8200
}

variable "instance-type" {
  type = string
  description = "type choice for vault server"
  default = "t2.micro"
}