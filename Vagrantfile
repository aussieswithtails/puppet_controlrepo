# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.vm.hostname = 'test-puppetmaster'
  config.vm.define "puppetmaster" do |puppetmaster|
    puppetmaster.vm.provision "shell", inline: "apt-get update && apt-get install -y puppetserver"
  end
  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "shell", inline: "sudo /opt/puppetlabs/bin/puppet module install zack/r10k"
  config.vm.provision "shell", inline: "sudo /opt/puppetlabs/bin/puppet apply /vagrant/bootstrap/r10k.pp"
  config.vm.provision "shell", inline: "sudo r10k deploy environment --verbose"
  config.vm.provision "puppet" do |puppet|
    puppet.binary_path = '/opt/puppetlabs/bin'
    puppet.environment = 'bootstrap'
    puppet.environment_path = "."
    puppet.manifest_file = 'bootstrap.pp'
    puppet.manifests_path = 'bootstrap/manifests'
    puppet.module_path = '.'
  end
end
