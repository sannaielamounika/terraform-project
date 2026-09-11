resource "aws_launch_template" "node" {
  for_each      = var.node_groups
  name          = "${local.name_prefix}-${each.key}-lt"
  instance_type = each.value.instance_types[0]

  vpc_security_group_ids = [
    aws_security_group.node.id
  ]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = each.value.disk_size
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "disabled"
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.common_tags,
      {
        Name = "${local.name_prefix}-${each.key}"
      }
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}
