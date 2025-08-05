data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["aws-sgtcloud-sbx-vpc"]
  }
}
