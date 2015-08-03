# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #config.vm.box = "sinatra-box"
  config.vm.box = "ManifestMedia/sinatra"
  
  #config.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)', ip:"192.168.1.102"
  config.vm.define 'spooner' do |node|
    node.vm.hostname = 'spooner'
    node.vm.network :private_network, ip: '192.168.2.105'
    #node.vm.network "public_network", bridge: "1"
    config.vm.synced_folder ".", "/var/www/app", :mount_options => ["dmode=777", "fmode=666"]
    node.hostmanager.aliases = %w(spooner.dev www.spooner.dev)
    node.vm.provision :shell do |sh|
      sh.path = "provision/provision.sh"
    end
  end
  #start nginx and unicorn on vagratn up/reload - via provisioning(ansible?)?
end