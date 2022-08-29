resource "aws_api_gateway_rest_api" "ShemaAPI" {
  name        = "ShemaAPI"
  description = "Demo API"
}

resource "aws_api_gateway_resource" "MyDemoResource" {
  rest_api_id = aws_api_gateway_rest_api.ShemaAPI.id
  parent_id   = aws_api_gateway_rest_api.ShemaAPI.root_resource_id
  path_part   = "mydemoresource"
}
