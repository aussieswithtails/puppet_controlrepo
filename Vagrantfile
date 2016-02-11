# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require 'yaml'
configurator = YAML.load_file(File.join(File.dirname(__FILE__), 'bootstrap/configuration.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "puppetserver" do |server|
    server.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
    server.vm.network "private_network", ip: '192.168.99.100'
    server.vm.provider "virtualbox" do |vbox|
      vbox.memory = 4096
    end
    server.vm.provision "shell", inline: "/vagrant/bootstrap/scripts/bootstrap_server.sh"
    server.vm.provision "Puppet Phase:", type: "puppet" do |puppet|
      puppet.binary_path = '/opt/puppetlabs/bin'
      puppet.environment = 'bootstrap'
      puppet.environment_path = "."
      puppet.manifest_file = 'bootstrap.pp'
      puppet.manifests_path = 'bootstrap/manifests'
      puppet.module_path = '.'
      puppet.options = '--verbose'
    end
  end
  config.vm.define "puppetagent" do |agent|
    agent.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
    agent.vm.network "private_network", ip: '192.168.99.101'
    agent.vm.provider "virtualbox" do |vbox|
      vbox.memory = 512
    end
    agent.vm.provision "shell", inline: "/vagrant/bootstrap/scripts/bootstrap_agent.sh"
    # agent.vm.provision "Puppet Phase:", type: "puppet" do |puppet|
    #   puppet.binary_path = '/opt/puppetlabs/bin'
    #   puppet.environment = 'br_vgnetwork'
    #   puppet.environment_path = "."
    #   puppet.manifest_file = 'bootstrap.pp'
    #   puppet.manifests_path = 'bootstrap/manifests'
    #   puppet.module_path = '.'
    #   puppet.options = '--verbose'
    #end
  end


  # config.vm.define "agent" do |agent|
  #   config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  #   config.vm.network "private_network","192.168.99.101"
  #   config.vm.provider "virtualbox" do |vbox|
  #     vbox.memory = 512
  #   end

end
