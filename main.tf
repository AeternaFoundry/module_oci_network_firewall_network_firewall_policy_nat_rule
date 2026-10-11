resource "oci_network_firewall_network_firewall_policy_nat_rule" "network_firewall_network_firewall_policy_nat_rules" {
  for_each = var.network_firewall_network_firewall_policy_nat_rules

  action                     = each.value.action
  name                       = each.value.name
  network_firewall_policy_id = each.value.network_firewall_policy_id
  type                       = each.value.type
  description                = each.value.description

  condition {
    destination_address = each.value.condition.destination_address
    service             = each.value.condition.service
    source_address      = each.value.condition.source_address
  }

  dynamic "position" {
    for_each = each.value.position != null ? [each.value.position] : []
    content {
      after_rule  = position.value.after_rule
      before_rule = position.value.before_rule
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

