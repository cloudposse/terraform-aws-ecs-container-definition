module "container" {
  source          = "../../"
  container_name  = "name"
  container_image = "cloudposse/geodesic"

  environment_files = [
    {
      value = "arn:aws:s3:::s3_bucket_name/envfile_01.env"
      type  = "s3"
    },
    {
      value = "arn:aws:s3:::s3_bucket_name/another_envfile.env"
      type  = "s3"
    }
  ]
}

output "json" {
  description = "Container definition in JSON format"
  value       = module.container.json_map
}
