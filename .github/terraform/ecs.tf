resource "aws_ecs_cluster" "shemaecs" {
  name = "shema-ecs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
