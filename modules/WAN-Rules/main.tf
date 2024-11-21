
provider "cato" { 
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

resource "cato_wf_section" "wanaccess" {
  at = {
    position = "LAST_IN_POLICY"
  }
  section = {
    name = "WAN Access"
  }
}

resource "cato_wf_rule" "grant-wan-access-p1" {
  at = {
    position = "FIRST_IN_SECTION"
    ref = cato_wf_section.wanaccess.section.id
  }
  rule = {
      name = "Grant WAN Access to Cloud WIN"
      description = "Grant WAN Access to Cloud WIN"
      enabled =  true
      direction = "TO"
      source = {
        users_group = [{
          name = var.p1_group_name
        }]
      }
      device = [{ "name": var.p1_device_posture_policy }]
      destination = {
        host = [{ "id": var.host_id } ],
      }
      action = "ALLOW"
      tracking = {
        event = {
          enabled = true
        }
      }
  }
}

resource "cato_wf_rule" "grant-wan-access-p2" {
  at = {
    position = "FIRST_IN_SECTION"
    ref = cato_wf_section.wanaccess.section.id
  }
  rule = {
      name = "Grant WAN Access to Cloud MacOS"
      description = "Grant WAN Access to Cloud MacOS"
      enabled =  true
      direction = "TO"
      source = {
        users_group = [{
          name = var.p2_group_name
        }]
      }
      device = [{ "name": var.p2_device_posture_policy }]
      destination = {
        host = [{ "id": var.host_id } ],
      }
      action = "ALLOW"
      tracking = {
        event = {
          enabled = true
        }
      }
  }
}

resource "cato_wf_rule" "block-wan-access" {
  at = {
    position = "LAST_IN_SECTION"
    ref = cato_wf_section.wanaccess.section.id
  }
  rule = {
      name = "Block All WAN Access"
      description = "Block All WAN Access"
      enabled =  true
      direction = "TO"
      action = "BLOCK"
      destination = {
        site = [{ "id": var.site_id } ],
      }
      tracking = {
        event = {
          enabled = true
        }
      }
  }
}