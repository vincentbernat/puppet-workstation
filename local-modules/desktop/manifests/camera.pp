# Camera related stuff

class desktop::camera {

  package { "exfat-fuse": ensure => installed } # exFAT filesystem
  package { "gphotofs": ensure => installed }   # PTP mount
  package { "darktable": ensure => installed }
  package { "shotwell": ensure => installed}

}
