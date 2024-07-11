output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "The public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "The private subnets"
  value       = aws_subnet.private[*].id
}

output "ecs_cluster_name" {
  description = "The ECS cluster name"
  value       = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  description = "The ECS service name"
  value       = aws_ecs_service.strapi.name
}
