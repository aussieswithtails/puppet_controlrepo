# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  # config.vm.define "puppetmaster" do |puppetmaster|
    config.vm.hostname = 'test-puppetmaster'
    config.vm.provision "shell", inline: "apt-get update"
    config.vm.provision "shell", inline: "sudo /opt/puppetlabs/bin/puppet module install zack/r10k"
    config.vm.provision "shell", inline: "sudo /opt/puppetlabs/bin/puppet apply /vagrant/environments/bootstrap/manifests/site.pp --test --debug"
  config.vm.provision "shell", inline: "sudo r10k deploy environment production --verbose"

end
#   config.vm.provision 'puppet' do |puppet|
#     puppet.environment_path = "./environments"
#     puppet.environment = "bootstrap"
# #    puppet.manifest_file = "site.pp"
# #    puppet.manifests_path = "manifests"
#   end
#end

#      puppet.options = '--verbose --debug'

#    end
#  end

