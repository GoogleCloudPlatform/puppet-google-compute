# Changelog

## 0.2.2 (2017-10-25)

### New features

- Added support for `gcompute_snapshot` resources.

## 0.2.1 (2017-10-11)

### Fixes

- #0001: Boolean[1] might be invalid

## 0.2.0 (2017-10-10)

### New features

- Improvements to `gcompute_instance` resource:
  * Added support for alias IP ranges in
  `network_configs { alias_ip_ranges => [ ... ] }`
  * Added support for `metadata`
  * Added support for `interface` in `disks [ { interface } ]`
  * Added support for `mode` in `disks [ { mode } ]`
  * Added support for `source_image_encryption_key` in
  `initializeParams { source_image_encryption_key }`
- Added support for `gcompute_forwarding_rule` resources.
- Added support for `gcompute_global_forwarding_rule` resources.
- Added support for `gcompute_instance_group_manager` resources.
- Added support for `gcompute_instance_template` resources.
- Added support for `gcompute_target_pool` resources.
- Added support for `gcompute_target_http_proxy` resources.
- Added support for `gcompute_target_https_proxy` resources.
- Added support for `gcompute_target_ssl_proxy` resources.
- Added support for `gcompute_target_tcp_proxy` resources.
- Added support for `gcompute_url_map` resources.
- Added Bolt task `instance` to (quickly) create new a VM instance.
- Added Bolt task `reset` to reset a VM instance.
- Added Bolt task `snapshot` to create a Disk snapshot.
- Added `gcompute_address_ip` client function.
- Added `gcompute_address_ref` client function.
- Added `gcompute_global_address_ref` client function.
- Added `gcompute_health_check_ref` client function.
- Added `gcompute_target_http_proxy_ref` client function.

### Fixes

- gcompute_instance { network_interfaces { subnetwork } } now accepts a reference to a
  gcompute_subnetwork resource instead of the GCP URL of a subnetwork
- Improved validation of required parameter references

## 0.1.0 (2017-08-22)

Initial release
