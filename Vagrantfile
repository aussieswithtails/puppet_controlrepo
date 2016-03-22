# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require 'yaml'
configurator = YAML.load_file(File.join(File.dirname(__FILE__), 'bootstrap/configuration.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "pserver" do |server|
    server.vm.box = "UbuntuWilyServer"
    server.ssh.username = 'administrator' # FixMe - Enable passwordless access, Parameterize
    server.ssh.password = '9073guss'
    # setting private network is broken as of wily due to systemd related change to interface naming.
    # Seehttps://github.com/mitchellh/vagrant/issues/6871
    #    server.vm.network "private_network", ip: '192.168.99.103'
    server.vm.hostname = 'puppetmaster01.test'
    server.vm.provider "virtualbox" do |vbox|
      vbox.memory = 4096
    end
    server.vm.provision "shell", inline: "/vagrant/bootstrap/scripts/bootstrap_server.sh puppetmaster01.test"
    server.vm.provision "shell", inline: "apt-get autoremove -y --purge "
    server.vm.provision "Provision Bootstrapper:", type: "puppet" do |puppet|
      puppet.binary_path = '/opt/puppetlabs/bin'
      puppet.environment = 'bootstrap'
      puppet.environment_path = "."
      puppet.manifest_file = 'configure_server.pp'
      puppet.manifests_path = 'bootstrap/manifests'
      puppet.module_path = ['.','./modules']
      puppet.options = '--verbose'
    end
    # server.vm.provision "Init:", type: 'puppet_server' do |pserver|
    #   pserver.options = '--test' #FixMe Add ability to debug
    #   pserver.puppet_server = 'puppetmaster01.test'
    # end
  end
  config.vm.define "pagent" do |agent|
    agent.vm.box = "UbuntuWilyServer1"
    agent.ssh.username = 'administrator'
    # agent.ssh.password = '9073guss'
    agent.ssh.insert_key = true
    # setting private network is broken as of wily due to systemd related change to interface naming.
    # Seehttps://github.com/mitchellh/vagrant/issues/6871
#    agent.vm.network "private_network", ip: '192.168.99.101'
    agent.vm.hostname = 'pagent.test'
    agent.vm.provider "virtualbox" do |vbox|
      vbox.memory = 1048
    end
    agent.vm.provision "shell", inline: "/vagrant/bootstrap/scripts/bootstrap_agent.sh"
    agent.vm.provision "shell", inline: "apt-get autoremove -y --purge " #FixMe - can this be DRYed out?
    agent.vm.provision "Puppet Phase:", type: "puppet" do |puppet|
      puppet.binary_path = '/opt/puppetlabs/bin'
      puppet.environment = 'bootstrap'
      puppet.environment_path = "."
      puppet.manifest_file = 'configure_agent.pp'
      puppet.manifests_path = 'bootstrap/manifests'
      puppet.module_path = ['.','./modules']
      puppet.options = '--verbose'
    end
  end
end
