resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "strapi/strapi:latest"
      essential = true
      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "DATABASE_CLIENT"
          value = "sqlite"
        },
        {
          name  = "DATABASE_FILENAME"
          value = "/data/data.db"
        }
      ]
      mountPoints = [
        {
          containerPath = "/data"
          sourceVolume  = "data"
        }
      ]
    }
  ])

  volume {
    name = "data"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.this.id
    }
  }

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
}
