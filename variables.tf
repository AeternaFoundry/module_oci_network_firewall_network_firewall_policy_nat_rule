variable "network_firewall_network_firewall_policy_nat_rules" {
  description = <<EOT
Map of network_firewall_network_firewall_policy_nat_rules, attributes below
Required:
    - action
    - name
    - network_firewall_policy_id
    - type
    - condition (block):
        - destination_address (optional)
        - service (optional)
        - source_address (optional)
Optional:
    - description
    - position (block):
        - after_rule (optional)
        - before_rule (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    action                     = string
    name                       = string
    network_firewall_policy_id = string
    type                       = string
    description                = optional(string)
    condition = object({
      destination_address = optional(list(string))
      service             = optional(string)
      source_address      = optional(list(string))
    })
    position = optional(object({
      after_rule  = optional(string)
      before_rule = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.network_firewall_network_firewall_policy_nat_rules : (
        contains([for v in ["NATV4"] : lower(v)], lower(v.type))
      )
    ])
    error_message = "must be one of: \"NATV4\""
  }
}

