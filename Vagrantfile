# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant::DEFAULT_SERVER_URL.replace('https://vagrantcloud.com')

Vagrant.configure(2) do |config|
  config.vm.box = "bento/ubuntu-16.04"
  #config.vm.box = "geerlingguy/ubuntu1604"
  #config.vm.box = "ubuntu/xenial64"
  config.ssh.insert_key = false
  # Increase memory for Parallels Desktop
  config.vm.provider "parallels" do |p, o|
    p.memory = "1024"
  end

  # Increase memory for Virtualbox
  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    #vb.customize ["modifyvm", :id, "--nic2", "nat"]
    vb.memory = "1024"
  end

  # Increase memory for VMware
  ["vmware_fusion", "vmware_workstation"].each do |p|
    config.vm.provider p do |v|
      v.vmx["memsize"] = "1024"
    end
  end

  # Begin SDP
  config.vm.define "master" do |c|
    c.vm.hostname = 'master'
    c.vm.provider "vmware_fusion" do |v|
      v.gui = true
      v.customize [
        "modifyvm", :id,
        "--cableconnected1", "on",
         "--rtcuseutc", "on"
      ]
      v.vmx["name"] = "master"
      v.vmx["numvcpus"] = "4"
      v.vmx["memsize"] = "2096"
      v.vmx["vhv.enable"] = "TRUE"
    end
    
  end 

  config.vm.define "satellite" do |c|
    c.vm.hostname = 'satellite'
    c.vm.provider "vmware_fusion" do |v|
      v.gui = true
      v.customize [
        "modifyvm", :id,
        "--cableconnected1", "on",
         "--rtcuseutc", "on"
      ]
      v.vmx["name"] = "satellite"
      v.vmx["numvcpus"] = "2"
      v.vmx["memsize"] = "2096"
      v.vmx["vhv.enable"] = "TRUE"
    end

  end

end  
