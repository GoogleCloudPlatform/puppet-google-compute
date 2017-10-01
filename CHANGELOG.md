# Changelog

## 0.1.1 (2017-09-19)

### New features

- Added `gcompute_address_ip` client function.
- Improvements to `gcompute_instance` resource:
  * Added support for alias IP ranges in
  `network_configs { alias_ip_ranges => [ ... ] }`
  * Added support for `metadata`
  * Added support for `interface` in `disks [ { interface } ]`
  * Added support for `mode` in `disks [ { mode } ]`
  * Added support for `source_image_encryption_key` in
  `initializeParams { source_image_encryption_key }`
- Added support for `gcompute_instance_template` resources.

### Fixes

- gcompute_instance { network_interfaces { subnetwork } } now accepts a
  reference to a gcompute_subnetwork resource instead of the GCP URL of a
  subnetwork

## 0.1.0 (2017-08-22)

Initial release
