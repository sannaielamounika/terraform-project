resource "aws_ebs_volume" "data" {
  availability_zone = aws_instance.this.availability_zone
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = true
  kms_key_id        = var.kms_key_arn

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-data-volume"
  })
}

resource "aws_volume_attachment" "data_attach" {
  device_name = var.data_device_name
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.this.id
}
