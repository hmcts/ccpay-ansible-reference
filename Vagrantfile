# -*- mode: ruby -*-
# vi: set ft=ruby :#
require_relative 'lib/inventory'

$vms = [
  { name: 'jenkins', memory: 512, ip: '10.0.0.10', groups: ['jenkins', 'ops'] },
  { name: 'cache', memory: 1024, ip: '10.0.0.27', groups: ['role_redis'] }
]
$groups = groupsFrom($vms)

def setup_ansible(ansible, playbook)
  ansible.verbose = ''
  ansible.playbook = playbook
  ansible.groups = $groups
  ansible.extra_vars = { "deploy_target" => "vagrant" }
  ansible.galaxy_role_file = "requirements.yml"
  ansible.galaxy_roles_path = "roles/"
  ansible.limit = "all" # Allow play access to info about other hosts
end

Vagrant.configure(2) do |config|

  $vms.each do |server|
    config.vm.define server[:name], autostart: false do |machine|
      hostname = "#{server[:name]}.reform.hmcts.dev"

      machine.vm.provider "virtualbox" do |virtualbox|
        virtualbox.memory = server[:memory]
      end

      machine.vm.box = 'centos/7'
      machine.vm.network "private_network", ip: "#{server[:ip]}"
      machine.vm.hostname = "#{hostname}"
    end
  end

  config.vm.provision "install", type: :ansible do |ansible|
    setup_ansible(ansible, "install.yml")
  end

  config.vm.provision "deploy", type: :ansible do |ansible|
    setup_ansible(ansible, "deploy.yml")
  end
end
