
def groupsFrom (vms)
  $vms.inject({ 'all'=>[] }) do |groups, vm|
    vm[:groups].each do |vm_group|
      groups[vm_group] ||= []
      groups[vm_group] << vm[:name]
    end
    groups['all'] << vm[:name]
    groups
  end
end
