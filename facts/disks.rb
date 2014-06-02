require 'augeas'

# Find ext* partitions missing noatime
Facter.add('fstab_missing_noatime') do
  list = []
  Augeas::open do |aug|
    aug.match("/files/etc/fstab/*[label()=~regexp('[0-9]+') " +
              "and vfstype=~regexp('ext.') " +
              "and count(opt[.='noatime']) = 0]").each do |match|
      list.push(match)
    end
  end
  setcode do
    list.join(',')
  end
end

# Find devices supporting discard and with discard not present in fstab
Facter.add('fstab_missing_discard') do
  list = []
  Augeas::open do |aug|
    aug.match("/files/etc/fstab/*[label()=~regexp('[0-9]+') " +
              "and count(opt[.='discard']) = 0]").each do |match|
      dev = aug.get("#{match}/spec")
      # We know that's a SSD behind this if discard granularity is not 0
      bytes = `lsblk --nodeps --noheadings --discard --output DISC-GRAN --bytes --raw #{dev} 2> /dev/null`.to_i
      list.push(match) if bytes > 0
    end
  end
  setcode do
    list.join(',')
  end
end
