require 'augeas'

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
