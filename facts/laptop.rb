Facter.add(:laptop) do
  setcode do
    if File.exists?("/usr/bin/laptop-detect") then
      !!system("/usr/bin/laptop-detect")
    end
  end
end
