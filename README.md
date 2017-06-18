# Google Compute Engine

#### Table of Contents

1. [Module Description - What the module does and why it is useful](
    #module-description)
2. [Setup - The basics of getting started with Google Compute Engine](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](
   #reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

This Puppet module manages the resource of Google Compute Engine.
You can manage its resources using standard Puppet DSL and the module will,
under the hood, ensure the state described will be reflected in the Google
Cloud Platform resources.

## Setup

To install this module on your Puppet Master (or Puppet Client/Agent), use the
Puppet module installer:

```
puppet module install google-gcompute
```

## Usage

### Credentials

All Google Cloud Platform modules use an unified authentication mechanism,
provided by the [`google-gauth`][] cookbook. Don't worry, it is automatically
installed when you install this module.

```puppet
gauth_credential { 'mycred':
  path     => $cred_path, # e.g. '/home/nelsonjr/my_account.json'
  provider => serviceaccount,
  scopes   => [
    'https://www.googleapis.com/auth/compute',
  ],
}
```

Please refer to the [`google-gauth`][] module for further requirements, i.e.
required gems.

### Resources

#### `gcompute_address`

```puppet
gcompute_region { 'some-region':
  ensure     => present,
  name       => 'us-west1',
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

gcompute_address { 'test1':
  ensure     => present,
  region     => 'some-region',
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```

#### `gcompute_disk_type`

```puppet
gcompute_disk_type { 'pd-standard':
  default_disk_size_gb => 500,
  deprecated_deleted   => undef, # undef = not deprecated
  zone                 => 'us-central1-a',
  project              => 'google.com:graphite-playground',
  credential           => 'mycred',
}

```

#### `gcompute_disk`

```puppet
gcompute_disk { 'data-disk-1':
  ensure              => present,
  size_gb             => 50,
  disk_encryption_key => {
    raw_key => 'SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0=',
  },
  zone                => 'us-central1-a',
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

#### `gcompute_firewall`

```puppet
gcompute_firewall { 'test-firewall-allow-ssh':
  ensure      => present,
  allowed     => [
    {
      ip_protocol => 'tcp',
      ports       => [
        '22',
      ],
    },
  ],
  target_tags => [
    'test-ssh-server',
    'staging-ssh-server',
  ],
  source_tags => [
    'test-ssh-clients',
  ],
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
}

```

#### `gcompute_global_address`

```puppet
gcompute_global_address { 'my-app-loadbalancer-address':
  ensure     => present,
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```

#### `gcompute_network`

```puppet
# Automatically allocated network
gcompute_network { "mynetwork-${network_id}":
  auto_create_subnetworks => true,
  project                 => 'google.com:graphite-playground',
  credential              => 'mycred',
}

# Manually allocated network
gcompute_network { "mynetwork-${network_id}":
  auto_create_subnetworks => false,
  project                 => 'google.com:graphite-playground',
  credential              => 'mycred',
}

# Legacy network
gcompute_network { "mynetwork-${network_id}":
  # On a legacy network you cannot specify the auto_create_subnetworks
  # parameter.
  # | auto_create_subnetworks => false,
  ipv4_range   => '192.168.0.0/16',
  gateway_ipv4 => '192.168.0.1',
  project      => 'google.com:graphite-playground',
  credential   => 'mycred',
}

# Converting automatic to custom network
gcompute_network { "mynetwork-${network_id}":
  auto_create_subnetworks => false,
  project                 => 'google.com:graphite-playground',
  credential              => 'mycred',
}

```

#### `gcompute_region`

```puppet
gcompute_region { 'us-west1':
  ensure     => present,
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```


## Reference

### Classes

#### Public classes

* [`gcompute_address`][]:
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
* [`gcompute_disk_type`][]:
    Represents a DiskType resource. A DiskType resource represents the type
    of disk to use, such as a pd-ssd or pd-standard. To reference a disk
    type, use the disk type's full or partial URL.
* [`gcompute_disk`][]:
    Persistent disks are durable storage devices that function similarly to
    the physical disks in a desktop or a server. Compute Engine manages the
    hardware behind these devices to ensure data redundancy and optimize
    performance for you. Persistent disks are available as either standard
    hard disk drives (HDD) or solid-state drives (SSD).
    Persistent disks are located independently from your virtual machine
    instances, so you can detach or move persistent disks to keep your data
    even after you delete your instances. Persistent disk performance
    scales
    automatically with size, so you can resize your existing persistent
    disks
    or add more persistent disks to an instance to meet your performance
    and
    storage space requirements.
    Add a persistent disk to your instance when you need reliable and
    affordable storage with consistent performance characteristics.
* [`gcompute_firewall`][]:
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
* [`gcompute_global_address`][]:
    Represents a Global Address resource. Global addresses are used for
    HTTP(S) load balancing.
* [`gcompute_network`][]:
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
* [`gcompute_region`][]:
    Represents a Region resource. A region is a specific geographical
    location where you can run your resources. Each region has one or more
    zones

### About output only properties

Some fields are output-only. It means you cannot set them because they are
provided by the Google Cloud Platform. Yet they are still useful to ensure the
value the API is assigning (or has assigned in the past) is still the value you
expect.

For example in a DNS the name servers are assigned by the Google Cloud DNS
service. Checking these values once created is useful to make sure your upstream
and/or root DNS masters are in sync.  Or if you decide to use the object ID,
e.g. the VM unique ID, for billing purposes. If the VM gets deleted and
recreated it will have a different ID, despite the name being the same. If that
detail is important to you you can verify that the ID of the object did not
change by asserting it in the manifest.

### Parameters

#### `gcompute_address`

Represents an Address resource.

Each virtual machine instance has an ephemeral internal IP address and,
optionally, an external IP address. To communicate between instances on
the same network, you can use an instance's internal IP address. To
communicate with the Internet and instances outside of the same network,
you must specify the instance's external IP address.

Internal IP addresses are ephemeral and only belong to an instance for
the lifetime of the instance; if the instance is deleted and recreated,
the instance is assigned a new internal IP address, either by Compute
Engine or by you. External IP addresses can be either ephemeral or
static.


#### Example

```puppet
gcompute_region { 'some-region':
  ensure     => present,
  name       => 'us-west1',
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

gcompute_address { 'test1':
  ensure     => present,
  region     => 'some-region',
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```

##### `address`

  The static external IP address represented by this
  resource. Only IPv4 is supported.

##### `description`

  An optional description of this resource.

##### `name`

  Name of the resource.

##### `region`

Required.  A reference to Region resource


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource.

* `users`: Output only.
  The URLs of the resources that are using this address.

#### `gcompute_disk_type`

Represents a DiskType resource. A DiskType resource represents the type
of disk to use, such as a pd-ssd or pd-standard. To reference a disk
type, use the disk type's full or partial URL.


#### Example

```puppet
gcompute_disk_type { 'pd-standard':
  default_disk_size_gb => 500,
  deprecated_deleted   => undef, # undef = not deprecated
  zone                 => 'us-central1-a',
  project              => 'google.com:graphite-playground',
  credential           => 'mycred',
}

```

##### `zone`

Required.  URL of the zone where the disk type resides.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `default_disk_size_gb`: Output only.
  Server-defined default disk size in GB.

* `deprecated_deleted`: Output only.
  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DELETED.

* `deprecated_deprecated`: Output only.
  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DEPRECATED.

* `deprecated_obsolete`: Output only.
  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to OBSOLETE.

* `deprecated_replacement`: Output only.
  The URL of the suggested replacement for a deprecated resource. The
  suggested replacement resource must be the same kind of resource as
  the deprecated resource.

* `deprecated_state`: Output only.
  The deprecation state of this resource. This can be DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource using a
  DEPRECATED resource will return successfully, but with a warning
  indicating the deprecated resource and recommending its replacement.
  Operations which use OBSOLETE or DELETED resources will be rejected
  and result in an error.

* `description`: Output only.
  An optional description of this resource.

* `id`: Output only.
  The unique identifier for the resource.

* `name`: Output only.
  Name of the resource.

* `valid_disk_size`: Output only.
  An optional textual description of the valid disk size, such as
  "10GB-10TB".

#### `gcompute_disk`

Persistent disks are durable storage devices that function similarly to
the physical disks in a desktop or a server. Compute Engine manages the
hardware behind these devices to ensure data redundancy and optimize
performance for you. Persistent disks are available as either standard
hard disk drives (HDD) or solid-state drives (SSD).

Persistent disks are located independently from your virtual machine
instances, so you can detach or move persistent disks to keep your data
even after you delete your instances. Persistent disk performance scales
automatically with size, so you can resize your existing persistent disks
or add more persistent disks to an instance to meet your performance and
storage space requirements.

Add a persistent disk to your instance when you need reliable and
affordable storage with consistent performance characteristics.


#### Example

```puppet
gcompute_disk { 'data-disk-1':
  ensure              => present,
  size_gb             => 50,
  disk_encryption_key => {
    raw_key => 'SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0=',
  },
  zone                => 'us-central1-a',
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `licenses`

  Any applicable publicly visible licenses.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

##### `size_gb`

  Size of the persistent disk, specified in GB. You can specify this
  field when creating a persistent disk using the sourceImage or
  sourceSnapshot parameter, or specify it alone to create an empty
  persistent disk.
  If you specify this field along with sourceImage or sourceSnapshot,
  the value of sizeGb must not be less than the size of the sourceImage
  or the size of the snapshot.

##### `source_image`

  The source image used to create this disk. If the source image is
  deleted, this field will not be set.
  To create a disk with one of the public operating system images,
  specify the image by its family name. For example, specify
  family/debian-8 to use the latest Debian 8 image:
  projects/debian-cloud/global/images/family/debian-8
  Alternatively, use a specific version of a public operating system
  image:
  projects/debian-cloud/global/images/debian-8-jessie-vYYYYMMDD
  To create a disk with a private image that you created, specify the
  image name in the following format:
  global/images/my-private-image
  You can also specify a private image by its image family, which
  returns the latest version of the image in that family. Replace the
  image name with family/family-name:
  global/images/family/my-private-family

##### `zone`

Required.  URL of the zone where the autoscaler resides.

##### `disk_encryption_key`

  Encrypts the disk using a customer-supplied encryption key.
  After you encrypt a disk with a customer-supplied key, you must
  provide the same key if you use the disk later (e.g. to create a disk
  snapshot or an image, or to attach the disk to a virtual machine).
  Customer-supplied encryption keys do not protect access to metadata of
  the disk.
  If you do not provide an encryption key when creating the disk, then
  the disk will be encrypted using an automatically generated key and
  you do not need to provide a key to use the disk later.

##### `source_image_encryption_key`

  The customer-supplied encryption key of the source image. Required if
  the source image is protected by a customer-supplied encryption key.

##### `source_snapshot`

  The source snapshot used to create this disk. You can provide this as
  a partial or full URL to the resource. For example, the following are
  valid values:
  * https://www.googleapis.com/compute/v1/projects/project/global/
  snapshots/snapshot
  * projects/project/global/snapshots/snapshot
  * global/snapshots/snapshot

##### `source_snapshot_encryption_key`

  The customer-supplied encryption key of the source snapshot. Required
  if the source snapshot is protected by a customer-supplied encryption
  key.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource.

* `last_attach_timestamp`: Output only.
  Last attach timestamp in RFC3339 text format.

* `last_detach_timestamp`: Output only.
  Last dettach timestamp in RFC3339 text format.

* `type`: Output only.
  URL of the disk type resource describing which disk type to use to
  create the disk. Provide this when creating the disk.

* `users`: Output only.
  Links to the users of the disk (attached instances) in form:
  project/zones/zone/instances/instance

* `source_image_id`: Output only.
  The ID value of the image used to create this disk. This value
  identifies the exact image that was used to create this persistent
  disk. For example, if you created the persistent disk from an image
  that was later deleted and recreated under the same name, the source
  image ID would identify the exact version of the image that was used.

* `source_snapshot_id`: Output only.
  The unique ID of the snapshot used to create this disk. This value
  identifies the exact snapshot that was used to create this persistent
  disk. For example, if you created the persistent disk from a snapshot
  that was later deleted and recreated under the same name, the source
  snapshot ID would identify the exact version of the snapshot that was
  used.

#### `gcompute_firewall`

Each network has its own firewall controlling access to and from the
instances.

All traffic to instances, even from other instances, is blocked by the
firewall unless firewall rules are created to allow it.

The default network has automatically created firewall rules that are
shown in default firewall rules. No manually created network has
automatically created firewall rules except for a default "allow" rule for
outgoing traffic and a default "deny" for incoming traffic. For all
networks except the default network, you must create any firewall rules
you need.


#### Example

```puppet
gcompute_firewall { 'test-firewall-allow-ssh':
  ensure      => present,
  allowed     => [
    {
      ip_protocol => 'tcp',
      ports       => [
        '22',
      ],
    },
  ],
  target_tags => [
    'test-ssh-server',
    'staging-ssh-server',
  ],
  source_tags => [
    'test-ssh-clients',
  ],
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
}

```

##### `allowed`

  The list of ALLOW rules specified by this firewall. Each rule
  specifies a protocol and port-range tuple that describes a permitted
  connection.

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

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


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource.

#### `gcompute_global_address`

Represents a Global Address resource. Global addresses are used for
HTTP(S) load balancing.


#### Example

```puppet
gcompute_global_address { 'my-app-loadbalancer-address':
  ensure     => present,
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```

##### `description`

  An optional description of this resource.
  Provide this property when you create the resource.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.


##### Output-only properties

* `address`: Output only.
  The static external IP address represented by this resource.

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource. This identifier is defined by
  the server.

* `region`: Output only.
  URL of the region where the regional address resides. This field is
  not applicable to global addresses.

#### `gcompute_network`

Represents a Network resource.

Your Cloud Platform Console project can contain multiple networks, and
each network can have multiple instances attached to it. A network allows
you to define a gateway IP and the network range for the instances
attached to that network. Every project is provided with a default network
with preset configurations and firewall rules. You can choose to customize
the default network by adding or removing rules, or you can create new
networks in that project. Generally, most users only need one network,
although you can have up to five networks per project by default.

A network belongs to only one project, and each instance can only belong
to one network. All Compute Engine networks use the IPv4 protocol. Compute
Engine currently does not support IPv6. However, Google is a major
advocate of IPv6 and it is an important future direction.


#### Example

```puppet
# Automatically allocated network
gcompute_network { "mynetwork-${network_id}":
  auto_create_subnetworks => true,
  project                 => 'google.com:graphite-playground',
  credential              => 'mycred',
}

# Manually allocated network
gcompute_network { "mynetwork-${network_id}":
  auto_create_subnetworks => false,
  project                 => 'google.com:graphite-playground',
  credential              => 'mycred',
}

# Legacy network
gcompute_network { "mynetwork-${network_id}":
  # On a legacy network you cannot specify the auto_create_subnetworks
  # parameter.
  # | auto_create_subnetworks => false,
  ipv4_range   => '192.168.0.0/16',
  gateway_ipv4 => '192.168.0.1',
  project      => 'google.com:graphite-playground',
  credential   => 'mycred',
}

# Converting automatic to custom network
gcompute_network { "mynetwork-${network_id}":
  auto_create_subnetworks => false,
  project                 => 'google.com:graphite-playground',
  credential              => 'mycred',
}

```

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `gateway_ipv4`

  A gateway address for default routing to other networks. This value is
  read only and is selected by the Google Compute Engine, typically as
  the first usable address in the IPv4Range.

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

##### `auto_create_subnetworks`

  When set to true, the network is created in "auto subnet mode". When
  set to false, the network is in "custom subnet mode".
  In "auto subnet mode", a newly created network is assigned the default
  CIDR of 10.128.0.0/9 and it automatically creates one subnetwork per
  region.


##### Output-only properties

* `id`: Output only.
  The unique identifier for the resource.

* `subnetworks`: Output only.
  Server-defined fully-qualified URLs for all subnetworks in this
  network.

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

#### `gcompute_region`

Represents a Region resource. A region is a specific geographical
location where you can run your resources. Each region has one or more
zones


#### Example

```puppet
gcompute_region { 'us-west1':
  ensure     => present,
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```

##### `name`

  Name of the resource.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `deprecated_deleted`: Output only.
  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DELETED.

* `deprecated_deprecated`: Output only.
  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to DEPRECATED.

* `deprecated_obsolete`: Output only.
  An optional RFC3339 timestamp on or after which the deprecation state
  of this resource will be changed to OBSOLETE.

* `deprecated_replacement`: Output only.
  The URL of the suggested replacement for a deprecated resource. The
  suggested replacement resource must be the same kind of resource as
  the deprecated resource.

* `deprecated_state`: Output only.
  The deprecation state of this resource. This can be DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource using a
  DEPRECATED resource will return successfully, but with a warning
  indicating the deprecated resource and recommending its replacement.
  Operations which use OBSOLETE or DELETED resources will be rejected
  and result in an error.

* `description`: Output only.
  An optional description of this resource.

* `id`: Output only.
  The unique identifier for the resource.

* `zones`: Output only.
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

### Contributing

Contributions to this library are always welcome and highly encouraged.

See [CONTRIBUTING.md][] for more information on how to get
started.

### Running tests

This project contains tests for [rspec][], [rspec-puppet][] and [rubocop][] to
verify functionality. For detailed information on using these tools, please see
their respective documentation.

#### Testing quickstart: Ruby > 2.0.0

```
gem install bundler
bundle install
bundle exec rspec
bundle exec rubocop
```

#### Debugging Tests

In case you need to debug tests in this module you can set the following
variables to increase verbose output:

Variable                | Side Effect
------------------------|---------------------------------------------------
`RSPEC_DEBUG=1`         | Prints debug related to the tests being run.
`GOOGLE_HTTP_VERBOSE=1` | Prints debug related to the network calls being made.
`GOOGLE_HTTP_DEBUG=1`   | Prints the payload of network calls being made.

[CONTRIBUTING.md]: CONTRIBUTING.md
[`google-gauth`]: https://github.com/GoogleCloudPlatform/puppet-google-auth
[rspec]: http://rspec.info/
[rspec-puppet]: http://rspec-puppet.com/
[rubocop]: https://rubocop.readthedocs.io/en/latest/
[`gcompute_address`]: #gcompute_address
[`gcompute_disk_type`]: #gcompute_disk_type
[`gcompute_disk`]: #gcompute_disk
[`gcompute_firewall`]: #gcompute_firewall
[`gcompute_global_address`]: #gcompute_global_address
[`gcompute_network`]: #gcompute_network
[`gcompute_region`]: #gcompute_region
