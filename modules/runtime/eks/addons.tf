resource "aws_eks_addon" "this" {
  for_each                    = var.addons
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  addon_version               = try(each.value.addon_version, null)
  resolve_conflicts_on_create = try(each.value.resolve_conflicts_on_create, "OVERWRITE")
  resolve_conflicts_on_update = try(each.value.resolve_conflicts_on_update, "PRESERVE")
  tags                        = local.common_tags
  depends_on = [
    aws_eks_node_group.this
  ]
}
