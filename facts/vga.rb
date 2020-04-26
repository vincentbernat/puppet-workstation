Facter.add(:vga) do
  setcode do
    data = %x[lspci -d ::0300 -vmm]
    data.split("\n").
      map { |line| line.split(/:\s+/, 2) }.
      map { |key, value| [key.downcase, value] }.
      to_h
  end
end
