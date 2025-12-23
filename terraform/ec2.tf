module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["Monitoring", "Ansible"])

  name = "${each.key}-Server"
  ami           = "ami-00d8fc944fb171e29"
  instance_type = "t3.micro"

  monitoring    = true
  subnet_id     = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.internal_server_sg.security_group_id]
  associate_public_ip_address = false

  key_name = aws_key_pair.ansible.key_name
}

module "web_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Web-Server"
  ami           = "ami-00d8fc944fb171e29"
  instance_type = "t3.micro"

  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  create_eip = true
  
  key_name = aws_key_pair.ansible.key_name
}