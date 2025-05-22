output "Socket_Site_Information" {
  value = module.socket-site.site
}

output "Socket_WAN_Interface_Information" {
  value = module.socket-site.wan_interfaces
}

output "Socket_Network_Range_Information" {
  value = flatten([
    for iface_key, iface_value in module.socket-site.lan_interfaces : [
      for subnet, net_info in iface_value.network_ranges : [
        for net_type in ["with_dhcp", "no_dhcp"] : [
          for range in net_info[net_type] : {
            interface_id     = iface_value.interface[0].interface_id
            interface_name   = iface_value.interface[0].name
            subnet           = range.subnet
            local_ip         = range.local_ip
            gateway          = range.gateway
            vlan             = range.vlan
            network_range_id = range.id
            dhcp_enabled     = net_type == "with_dhcp"
            dhcp_settings    = range.dhcp_settings
            range_type       = range.range_type
          }
        ]
      ]
    ]
  ])
}