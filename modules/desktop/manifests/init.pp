# desktop-related applications

class desktop {

  include x11

  # Base desktop
  include pulseaudio
  include awesome
  include urxvt
  include fonts

  # Some applications
  include applications
  include emacs
  include chromium
  include spotify
  include skype
}
