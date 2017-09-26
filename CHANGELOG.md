# Changelog

## 0.1.1 (2017-09-19)

### New features

- Added `gcompute_address_ip` client function.
- Added support for `gcompute_instance_template` resources.
- Added support for alias IP ranges in `gcompute_instance { network_configs {
  alias_ip_ranges => [ ... ] } }`
- Added support for metadata in `gcompute_instance { metadata }`
- Added support for interface in disks in `gcompute_instance { disks [
  interface ] }`
- Added support for mode in disks in `gcompute_instance { disks [ disks ] }`
- Added support for source_image_encryption_key in initializeParams in
  `gcompute_instance { initializeParamas { source_image_encryption_key } }`

### Fixes

- gcompute_instance { network_interfaces { subnetwork } } now accepts a
  reference to a gcompute_subnetwork resource instead of the GCP URL of a
  subnetwork

## 0.1.0 (2017-08-22)

Initial release
