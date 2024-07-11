resource "aws_efs_file_system" "this" {
  creation_token = "strapi"
  tags = {
    Name = "strapi-efs"
  }
}

resource "aws_efs_mount_target" "this" {
  count           = length(var.private_subnets)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = element(aws_subnet.private.*.id, count.index)
  security_groups = [aws_security_group.ecs.id]
}
