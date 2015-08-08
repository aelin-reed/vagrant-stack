Vagrant.configure(2) do |config|
  # Set the base box to Ubuntu 14.04 LTS.
  config.vm.box = "ubuntu/trusty32"

  # Forward guest port 80 to host port 8080.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Sync the vagrant folder with the guest. The subfolder 'public' will be used
  # as the document root by apache.
  config.vm.synced_folder "./vagrant", "/vagrant"
  
  # Provision the virtual machine using the 'bootstrap.sh' script.
  config.vm.provision :shell, path: "bootstrap.sh"
end