Facter.add(:drm) do
  # Retrieve some facts related to DRM subsystem
  setcode do
    Dir['/sys/class/drm/card?'].map { |card|
      [
        File.basename(card),
        {
          'maxwidth' => Dir["#{card}/card0*/modes"].map { |modes|
            File.read(modes).split('\n').map { |m| m.split('x')[0].to_i }.max
          }.compact.max,
          'driver' => File.basename(File.realpath("#{card}/device/driver"))
        }
      ]
    }.to_h
  end
end
