locals {
  network_ranges_csv = csvdecode(file(var.socket_lan_network_ranges_csv_path))
  lan_interfaces = [
    for int_id in distinct([for row in local.network_ranges_csv : row.interface_id]) : {
      interface_id      = int_id
      name              = [for row in local.network_ranges_csv : row.name if row.interface_id == int_id && row.range_type == "Default"][0]
      dest_type         = "LAN"
      subnet            = [for row in local.network_ranges_csv : row.subnet if row.interface_id == int_id && row.range_type == "Default"][0]
      local_ip          = [for row in local.network_ranges_csv : row.local_ip if row.interface_id == int_id && row.range_type == "Default"][0]
      translated_subnet = null
      network_ranges = [
        for idx, row in [
          for r in local.network_ranges_csv : r
          if r.interface_id == int_id && r.range_type != "Default"
          ] : {
          name              = row.name
          range_type        = row.range_type
          subnet            = row.subnet
          local_ip          = row.local_ip != "" ? row.local_ip : null
          gateway           = row.gateway != "" ? row.gateway : null
          vlan              = row.range_type == "VLAN" ? 10 + idx + (int_id == "INT_6" ? 0 : 1) : null
          translated_subnet = row.translated_subnet != "" ? row.translated_subnet : null
          dhcp_settings = row.dhcp_type != "" ? {
            dhcp_type = row.dhcp_type
            ip_range  = row.ip_range
          } : null
        }
      ]
    }
  ]
}

module "socket-site" {
  source               = "catonetworks/socket/cato"
  site_name            = var.site_name
  site_description     = var.site_description
  native_network_range = var.native_network_range
  local_ip             = var.local_ip
  site_type            = var.site_type
  connection_type      = var.connection_type
  site_location        = var.site_location
  cato_interfaces      = var.cato_interfaces
  lan_interfaces       = local.lan_interfaces
}
