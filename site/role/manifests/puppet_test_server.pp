# Class: role::puppet_test_server
#
# This class defines the role of the puppet_test_server
#
# Sample Usage:
#
#   include ::role::puppet_test_server
#
class role::puppet_test_server {
  include profile::puppet::master
}