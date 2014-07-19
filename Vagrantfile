# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "trusty32"

  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

  config.vm.network :forwarded_port, host:1999, guest: 8000

  # this is needed so that puppet doesn't complain about the lack of a fqdn in our box
  config.vm.hostname = "rbox.example.com"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
     # Don't boot with headless mode
     vb.gui = true
     vb.name='r-box'  
     # Use VBoxManage to customize the VM. For example to change memory:
     vb.memory = 1024
   end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # install puppetlabs/stdlib module
  config.vm.provision :shell, :inline => "mkdir -p /etc/puppet/modules && ( (puppet module list | grep puppetlabs-stdlib) || puppet module install puppetlabs/stdlib)"
  
  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
  end

end
