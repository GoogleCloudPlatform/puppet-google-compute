# Google Compute Engine

#### Table of Contents

1. [Module Description - What the module does and why it is useful]
   (#module-description)
2. [Setup - The basics of getting started with Google Compute Engine](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how]
   (#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

TODO(nelsonjr): Add documentation

## Setup

TODO(nelsonjr): Add documentation

## Usage

TODO(nelsonjr): Add documentation

## Reference

### Classes

#### Public classes

* [`gcompute_address`](#gcompute_address):
    Represents an Address resource.
    Each virtual machine instance has an ephemeral internal IP address and,
    optionally, an external IP address. To communicate between instances on
    the same network, you can use an instance's internal IP address. To
    communicate with the Internet and instances outside of the same
    network,
    you must specify the instance's external IP address.
    Internal IP addresses are ephemeral and only belong to an instance for
    the lifetime of the instance; if the instance is deleted and recreated,
    the instance is assigned a new internal IP address, either by Compute
    Engine or by you. External IP addresses can be either ephemeral or
    static.
* [`gcompute_disk_type`](#gcompute_disk_type):
    Represents a DiskType resource. A DiskType resource represents the type
    of disk to use, such as a pd-ssd or pd-standard. To reference a disk
    type, use the disk type's full or partial URL.
* [`gcompute_firewall`](#gcompute_firewall):
    Each network has its own firewall controlling access to and from the
    instances.
    All traffic to instances, even from other instances, is blocked by the
    firewall unless firewall rules are created to allow it.
    The default network has automatically created firewall rules that are
    shown in default firewall rules. No manually created network has
    automatically created firewall rules except for a default "allow" rule
    for
    outgoing traffic and a default "deny" for incoming traffic. For all
    networks except the default network, you must create any firewall rules
    you need.
* [`gcompute_network`](#gcompute_network):
    Represents a Network resource.
    Your Cloud Platform Console project can contain multiple networks, and
    each network can have multiple instances attached to it. A network
    allows
    you to define a gateway IP and the network range for the instances
    attached to that network. Every project is provided with a default
    network
    with preset configurations and firewall rules. You can choose to
    customize
    the default network by adding or removing rules, or you can create new
    networks in that project. Generally, most users only need one network,
    although you can have up to five networks per project by default.
    A network belongs to only one project, and each instance can only
    belong
    to one network. All Compute Engine networks use the IPv4 protocol.
    Compute
    Engine currently does not support IPv6. However, Google is a major
    advocate of IPv6 and it is an important future direction.
* [`gcompute_region`](#gcompute_region):
    Represents a Region resource. A region is a specific geographical
    location where you can run your resources. Each region has one or more
    zones

### Parameters

#### `gcompute_address`

##### `address`

  The static external IP address represented by this
  resource. Only IPv4 is supported.

##### `creation_timestamp`

  Creation timestamp in RFC3339 text format.

##### `description`

  An optional description of this resource.

##### `id`

  The unique identifier for the resource.

##### `name`

  Name of the resource.

##### `region`

  URL of the region where the regional address resides.
  This field is not applicable to global addresses.

##### `users`

  The URLs of the resources that are using this address.

#### `gcompute_disk_type`

##### `creation_timestamp`

  Creation timestamp in RFC3339 text format.

##### `default_disk_size_gb`

  Server-defined default disk size in GB.

##### `deprecated_deleted`

  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DELETED.

##### `deprecated_deprecated`

  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DEPRECATED.

##### `deprecated_obsolete`

  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to OBSOLETE.

##### `deprecated_replacement`

  The URL of the suggested replacement for a deprecated resource. The
  suggested replacement resource must be the same kind of resource as
  the deprecated resource.

##### `deprecated_state`

  The deprecation state of this resource. This can be DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource using a
  DEPRECATED resource will return successfully, but with a warning
  indicating the deprecated resource and recommending its replacement.
  Operations which use OBSOLETE or DELETED resources will be rejected
  and result in an error.

##### `description`

  An optional description of this resource.

##### `id`

  The unique identifier for the resource.

##### `name`

  Name of the resource.

##### `valid_disk_size`

  An optional textual description of the valid disk size, such as
  "10GB-10TB".

##### `zone`

  URL of the zone where the disk type resides.

#### `gcompute_firewall`

##### `allowed`

  The list of ALLOW rules specified by this firewall. Each rule
  specifies a protocol and port-range tuple that describes a permitted
  connection.

##### `creation_timestamp`

  Creation timestamp in RFC3339 text format.

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `id`

  The unique identifier for the resource.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

##### `network`

  URL of the network resource for this firewall rule. If not specified
  when creating a firewall rule, the default network is used:
  global/networks/default
  If you choose to specify this property, you can specify the network as
  a full or partial URL. For example, the following are all valid URLs:
  https://www.googleapis.com/compute/v1/projects/myproject/global/
  networks/my-network
  projects/myproject/global/networks/my-network
  global/networks/default

##### `source_ranges`

  If source ranges are specified, the firewall will apply only to
  traffic that has source IP address in these ranges. These ranges must
  be expressed in CIDR format. One or both of sourceRanges and
  sourceTags may be set. If both properties are set, the firewall will
  apply to traffic that has source IP address within sourceRanges OR the
  source IP that belongs to a tag listed in the sourceTags property. The
  connection does not need to match both properties for the firewall to
  apply. Only IPv4 is supported.

##### `source_tags`

  If source tags are specified, the firewall will apply only to traffic
  with source IP that belongs to a tag listed in source tags. Source
  tags cannot be used to control traffic to an instance's external IP
  address. Because tags are associated with an instance, not an IP
  address. One or both of sourceRanges and sourceTags may be set. If
  both properties are set, the firewall will apply to traffic that has
  source IP address within sourceRanges OR the source IP that belongs to
  a tag listed in the sourceTags property. The connection does not need
  to match both properties for the firewall to apply.

##### `target_tags`

  A list of instance tags indicating sets of instances located in the
  network that may make network connections as specified in allowed[].
  If no targetTags are specified, the firewall rule applies to all
  instances on the specified network.

#### `gcompute_network`

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `gateway_ipv4`

  A gateway address for default routing to other networks. This value is
  read only and is selected by the Google Compute Engine, typically as
  the first usable address in the IPv4Range.

##### `id`

  The unique identifier for the resource.

##### `ipv4_range`

  The range of internal addresses that are legal on this network. This
  range is a CIDR specification, for example: 192.168.0.0/16. Provided
  by the client when the network is created.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

##### `subnetworks`

  Server-defined fully-qualified URLs for all subnetworks in this
  network.

##### `auto_create_subnetworks`

  When set to true, the network is created in "auto subnet mode". When
  set to false, the network is in "custom subnet mode".
  In "auto subnet mode", a newly created network is assigned the default
  CIDR of 10.128.0.0/9 and it automatically creates one subnetwork per
  region.

##### `creation_timestamp`

  Creation timestamp in RFC3339 text format.

#### `gcompute_region`

##### `creation_timestamp`

  Creation timestamp in RFC3339 text format.

##### `deprecated_deleted`

  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DELETED.

##### `deprecated_deprecated`

  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DEPRECATED.

##### `deprecated_obsolete`

  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to OBSOLETE.

##### `deprecated_replacement`

  The URL of the suggested replacement for a deprecated resource. The
  suggested replacement resource must be the same kind of resource as
  the deprecated resource.

##### `deprecated_state`

  The deprecation state of this resource. This can be DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource using a
  DEPRECATED resource will return successfully, but with a warning
  indicating the deprecated resource and recommending its replacement.
  Operations which use OBSOLETE or DELETED resources will be rejected
  and result in an error.

##### `description`

  An optional description of this resource.

##### `id`

  The unique identifier for the resource.

##### `name`

  Name of the resource.

##### `zones`

  List of zones within the region

## Limitations

This module has been tested on:

* RedHat 6, 7
* CentOS 6, 7
* Debian 7, 8
* Ubuntu 12.04, 14.04, 16.04, 16.10
* SLES 11-sp4, 12-sp2
* openSUSE 13

Testing on other platforms has been minimal and cannot be guaranteed.

## Development

TODO(nelsonjr): Add documentation
