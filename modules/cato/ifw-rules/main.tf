resource "cato_if_section" "if_section" {
  at = {
    position = "LAST_IN_POLICY"
  }
  section = {
    name = "IFW Section"
  }
}

resource "cato_if_rule" "allowrule" {
  at = {
    position = "FIRST_IN_SECTION"
    ref      = cato_if_section.if_section.section.id
  }
  rule = {
    name        = "DEMO-Allow-Rule"
    description = "DEMO-Allow-Rule"
    enabled     = true
    source = {
      users_group = var.ifw_group_names
    }
    destination = {
      domain = var.allow_domains
    }
    action = "ALLOW"
    tracking = {
      event = {
        enabled = true
      }
    }
  }
}

resource "cato_if_rule" "blockrule" {
  at = {
    position = "FIRST_IN_SECTION"
    ref      = cato_if_section.if_section.section.id
  }
  rule = {
    name             = "DEMO-Block-Rule"
    description      = "DEMO-Block-Rule"
    enabled          = true
    connectionorigin = "ANY"
    source = {
      users_group = var.ifw_group_names
    }
    destination = {
      domain = var.block_domains
    }
    action = "BLOCK"
    tracking = {
      event = {
        enabled = true
      }
    }
  }
}

resource "cato_if_rule" "promptrule" {
  at = {
    position = "FIRST_IN_SECTION"
    ref      = cato_if_section.if_section.section.id
  }
  rule = {
    name             = "DEMO-Prmopt-Rule"
    description      = "DEMO-Prmopt-Rule"
    enabled          = true
    connectionorigin = "ANY"
    source = {
      users_group = var.ifw_group_names
    }
    destination = {
      domain = var.prompt_domains
    }
    service = {}
    action  = "PROMPT"
    tracking = {
      event = {
        enabled = true
      }
    }
  }
}

resource "cato_if_rule" "rbirule" {
  at = {
    position = "FIRST_IN_SECTION"
    ref      = cato_if_section.if_section.section.id
  }
  rule = {
    action           = "RBI"
    name             = "DEMO-RBI-Rule"
    description      = "DEMO-RBI-Rule"
    enabled          = true
    connectionorigin = "ANY"
    source = {
      users_group = var.ifw_group_names
    }
    destination = {
      custom_category = [
        {
          name = var.rbi_category
        }
      ]
    }
    tracking = {
      event = {
        enabled = true
      }
    }
  }
}
