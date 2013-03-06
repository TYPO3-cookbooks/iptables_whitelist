# default[:iptables_whitelist][:tcp_port_by_role] = nil

# example
#
# default[:iptables_whitelist][:tcp_port_by_role] = {
#  "8080" => "loadbalancer",
#  "3006" => "app_server"
# }

# default[:iptables_whitelist][:tcp_port_by_ip] = {
#  "80" => "1.2.3.4"
# }