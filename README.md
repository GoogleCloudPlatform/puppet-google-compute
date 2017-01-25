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

* [`gcompute_disk_type`](#gcompute_disk_type):
    Represents a DiskType resource. A DiskType resource represents the type
    of
    disk to use, such as a pd-ssd or pd-standard. To reference a disk type,
    use the disk type's full or partial URL.
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

### Parameters

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

#### `gcompute_network`

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `gateway_ipv4`

  A gateway address for default routing to other networks. This value is
  read only and is selected by the Google Compute Engine, typically as
  the first usable address in the IPv4Range.

##### `id`

  Unique identifier for the resource; defined by the server.

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
