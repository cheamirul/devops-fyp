module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws/"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "internal_server_sg" {
  source = "terraform-aws-modules/security-group/aws/"

  name        = "internal-server"
  description = "Security group for internal-server with SSH access only"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
}