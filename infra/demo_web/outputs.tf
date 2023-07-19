output "ecs_task_security_group_id" {
  value = aws_security_group.ecs_task_sg.id
}

# The load balancer DNS name
output "alb_dns" {
  value = aws_alb.main.dns_name
}

output "alb_arn" {
  value = aws_alb.main.arn
}

output "alb_http_listener_arn" {
  value = try(aws_alb_listener.http.arn, null)
}

output "alb_zone_id" {
  value = aws_alb.main.zone_id
}

output "docker_registry_url" {
  value = aws_ecr_repository.ecr_repo.repository_url
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}

