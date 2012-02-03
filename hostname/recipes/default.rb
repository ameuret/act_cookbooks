#
# Cookbook Name:: hostname
# Recipe:: default
# 
# This recipe is meant to be used at bootstrap time only. The host
# name and the domain name will be derived from the Chef node name
# set from the knife bootstrap command line by using the -N
# node_name option.
#
# Copyright 2012, Groupe ACTIME
#
# All rights reserved - Do Not Redistribute
#

EC2_SCRIPTS = node[:act_hostname][:ec2_scripts]
SCRIPT_NAME = node[:act_hostname][:script_name]
STARTUP_SCRIPT = node[:act_hostname][:startup_script]

# Install the hostname/domain setter script
directory EC2_SCRIPTS do
  owner "root"
  group "root"
  mode '0755'
end

# Create the setter shell script
# The hostname and domain are retrieved by inline code in the erb file
template "#{EC2_SCRIPTS}/#{SCRIPT_NAME}" do
  
  source "set-hostname.erb"
  owner "root"
  group "root"
  mode '0711'
  
  if !(Chef::Config[:node_name] =~ /^([a-z]+)\.(.+)/)
    raise( ArgumentError, "This recipe requires the node_name to be set, please use the -N option during bootstrap to set a FQDN such as www.example.com" )
  end
  
  node.set[:act_hostname][:hostname] = $1
  node.set[:act_hostname][:domain] = $2
  Chef::Log.info( "Generating script with hostname: #{node[:act_hostname][:hostname]}, domain: #{node[:act_hostname][:domain]}")
end

# Run the shell script to set the host/domain names
execute "#{EC2_SCRIPTS}/#{SCRIPT_NAME}"

# Append to the local startup script to make sure the setter script is called on every boot
file STARTUP_SCRIPT do
  mode '0755'
  owner "root"
  group "root"
  not_if "grep '#{SCRIPT_NAME}' #{STARTUP_SCRIPT}"
  content File.read(STARTUP_SCRIPT) + "\n#{EC2_SCRIPTS}/#{SCRIPT_NAME}\n"
end
