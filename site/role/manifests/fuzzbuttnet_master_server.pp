# Class: role::fuzzbuttnet_master_server
#
# This class defines the role of the fuzzbuttnet master server
#
# Sample Usage:
#
#   include ::role::fuzzbuttnet_master_server
class role::fuzzbuttnet_master_server {
#  include ::profile::webserver
#  include ::profile::base
#  include ::profile::puppet::master
#  include ::profile::puppet::puppetdb_server
  # include ::profile::vmhost
  # include ::profile::vagrant_server
  # # include profile::ad_controller::backup_domain_controller
  # include ::profile::vcs::git_server
}
