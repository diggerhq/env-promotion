resource "aws_instance" "ec2_instance" {
  ami = "ami-0a23ccb2cdd9286bb"
  instance_type = "m6.xlarge"
}
