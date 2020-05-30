# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.hostname = 'dealogic'
  config.vm.network 'public_network'
  config.vm.provision :shell, path: "provision.sh", privileged: false
  config.vm.provider :vmware_desktop do |v|
    v.memory = 2048
    v.cpus = 1
  end
  config.ssh.forward_agent = true
  config.mutagen.orchestrate = true
end
