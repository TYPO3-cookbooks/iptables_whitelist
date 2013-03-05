include_recipe "simple_iptables"

dport = 2003
role_search = "*"

nodes = {}

# for testing with e.g. vagrant (then uncomment the next paragraph!)
# nodes = { :your_machine => "192.168.156.1", :other_machine => "192.168.156.2" }

search(:node, "role:#{role_search}").reject{ |n| n[:ipaddress] == nil }.each do |n|
  nodes[n[:fqdn]] = n[:ipaddress]
end

Chef::Log.info "Whitelisting the following IPs for port #{dport}: " +  nodes.sort.inspect

# ACCEPT all known hosts
nodes.values.each do |ip|
  simple_iptables_rule "graphite" do
    direction "INPUT"
    rule "--proto tcp --dport #{dport} --src #{ip}"
    jump "ACCEPT"
  end
end

# DROP everything else
simple_iptables_rule "graphite" do
  direction "INPUT"
  rule "--proto tcp --dport #{dport}"
  jump "DROP"
end