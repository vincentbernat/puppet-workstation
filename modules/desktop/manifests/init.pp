# desktop-related applications

class desktop {

  include x11

  # Base desktop
  include pulseaudio
  include awesome
  include urxvt

  # Some applications
  include applications
  include chromium
  include spotify
  include skype
}
