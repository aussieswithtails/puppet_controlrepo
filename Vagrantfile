# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require 'yaml'
configurator = YAML.load_file(File.join(File.dirname(__FILE__), 'bootstrap/configuration.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.vm.provider "virtualbox" do |vbox|
    vbox.memory = 4096
  end
  config.vm.define "puppetmaster" do |puppetmaster|
    puppetmaster.vm.hostname = 'puppetmaster.test.fuzzbutt'
    puppetmaster.vm.provision "shell", inline: "/vagrant/bootstrap/scripts/bootstrap.sh"
    puppetmaster.vm.provision "Puppet Phase:", type: "puppet" do |puppet|
      puppet.binary_path = '/opt/puppetlabs/bin'
      puppet.environment = 'bootstrap'
      puppet.environment_path = "."
      puppet.manifest_file = 'bootstrap.pp'
      puppet.manifests_path = 'bootstrap/manifests'
      puppet.module_path = '.'
      puppet.options = '--verbose'
    end
  end
end
