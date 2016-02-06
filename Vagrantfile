# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.vm.define "puppetmaster" do |puppetmaster|
    puppetmaster.vm.hostname = 'test-puppetmaster'
    puppetmaster.vm.provision "shell", inline: "/vagrant/bootstrap/scripts/bootstrap.sh"
    puppetmaster.vm.provision "Puppet Phase:", type: "puppet" do |puppet|
      puppet.binary_path = '/opt/puppetlabs/bin'
      puppet.environment = 'bootstrap'
      puppet.environment_path = "."
      puppet.manifest_file = 'bootstrap.pp'
      puppet.manifests_path = 'bootstrap/manifests'
      puppet.module_path = '.'
    end
  end
end
