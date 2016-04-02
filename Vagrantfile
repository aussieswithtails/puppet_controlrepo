# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require 'yaml'
 test_servers = YAML.load_file(File.join(File.dirname(__FILE__), 'bootstrap/dev_servers.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  test_servers.each do |servers|
    config.vm.define servers['name'] do |srv|
      if servers['ip_addr'] != nil
        # auto_config currently breaks under wily because of systemd related changes to interface naming
        srv.vm.network 'private_network', ip: servers['ip_addr'], auto_config: false
      end
      srv.vm.box = servers['box']
      srv.vm.hostname = servers['hostname']
      srv.ssh.username = 'administrator'
      srv.vm.provider 'virtualbox' do |vbox|
        vbox.memory = servers['ram']
      end
    end
  end
end

