Facter.add(:laptop) do
  setcode do
    if File.exists?("/usr/sbin/laptop-detect") then
      system("/usr/sbin/laptop-detect")
    end
  end
end
