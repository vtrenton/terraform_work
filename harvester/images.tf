resource "harvester_image" "debian" {
  name         = "debian"
  namespace    = "harvester-public"
  display_name = "debian_netinst"
  source_type  = "download"
  url          = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso"
}

resource "harvester_image" "opensuse" {
  name         = "opensuse"
  namespace    = "harvester-public"
  display_name = "OpenSUSE"
  source_type  = "download"
  url          = "https://download.opensuse.org/distribution/leap/15.3/iso/openSUSE-Leap-15.3-NET-x86_64-Media.iso"
}
