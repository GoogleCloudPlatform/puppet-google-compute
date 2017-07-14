# Google Compute Engine Puppet Module

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
provided by the [`google-gauth`][] module. Don't worry, it is automatically
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

#### `gcompute_backend_bucket`

```puppet
gcompute_backend_bucket { 'be-bucket-connection':
  ensure      => present,
  bucket_name => 'backend-bucket-test',
  description => 'A BackendBucket to connect LNB w/ Storage Bucket',
  enable_cdn  => true,
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
}

```

#### `gcompute_backend_service`

```puppet
# Backend Service requires various other services to be setup beforehand. Please
# make sure they are defined as well:
#   - gcompute_instance_group { ... }
#   - Health check
gcompute_backend_service { 'my-app-backend':
  ensure        => present,
  backends      => [
    { group => 'my-puppet-masters' },
  ],
  enable_cdn    => true,
  health_checks => [
    $my_health_check,
  ],
  project       => 'google.com:graphite-playground',
  credential    => 'mycred',
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

#### `gcompute_http_health_check`

```puppet
gcompute_http_health_check { 'my-app-http-hc':
  ensure              => present,
  healthy_threshold   => 10,
  port                => 8080,
  timeout_sec         => 2,
  unhealthy_threshold => 5,
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

#### `gcompute_https_health_check`

```puppet
gcompute_https_health_check { 'my-app-https-hc':
  ensure              => present,
  healthy_threshold   => 10,
  port                => 8080,
  timeout_sec         => 2,
  unhealthy_threshold => 5,
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

#### `gcompute_health_check`

```puppet
gcompute_health_check { 'my-app-tcp-hc':
  ensure              => present,
  type                => 'TCP',
  tcp_health_check    => {
    port_name => 'service-health',
    request   => 'ping',
    response  => 'pong',
  },
  healthy_threshold   => 10,
  timeout_sec         => 2,
  unhealthy_threshold => 5,
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

#### `gcompute_license`

```puppet
gcompute_license { 'test-license':
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```

#### `gcompute_image`

```puppet
# Tip: Be sure to include a valid gcompute_disk object
gcompute_image { 'test-image':
  ensure      => present,
  source_disk => 'data-disk-1',
  project     => 'google.com:graphite-playground',
  credential  => 'mycred'
}

```

#### `gcompute_instance`

```puppet
# Tip: Remember to define gsql_disk to match the 'disk' property.
# Tip: Remember to define gsql_network to match the 'network' property.
gcompute_instance { 'instance-test':
  ensure             => present,
  machine_type       => 'https://www.googleapis.com/compute/v1/projects/google.com:graphite-playground/zones/us-central1-a/machineTypes/n1-standard-1',
  disks              => [
    {
      boot   => true,
      source => 'data-disk-1'
    }
  ],
  network_interfaces => [
    {
      network => 'mynetwork-test',
    }
  ],
  zone               => 'us-central1-a',
  project            => 'google.com:graphite-playground',
  credential         => 'mycred',
}

```

#### `gcompute_instance_group`

```puppet
# Instance group requires a network, so define them in your manifest:
#   - gcompute_network { 'my-network': ensure => present }
gcompute_instance_group { 'my-puppet-masters':
  ensure      => present,
  named_ports => [
    {
      name => 'puppet',
      port => 8140,
    },
  ],
  network     => 'my-network',
  zone        => 'us-central1-a',
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
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

#### `gcompute_route`

```puppet
# Subnetwork requires a network and a region, so define them in your manifest:
#   - gcompute_network { 'my-network': ensure => presnet }
#   - gcompute_region { 'some-region': ensure => present }
gcompute_route { 'corp-route':
  ensure           => present,
  dest_range       => '192.168.6.0/24',
  next_hop_gateway => 'global/gateways/default-internet-gateway',
  network          => 'my-network',
  tags             => ['backends', 'databases'],
  project          => 'google.com:graphite-playground',
  credential       => 'mycred',
}

```

#### `gcompute_ssl_certificate`

```puppet
# *******
# WARNING: This manifest is for example purposes only. It is *not* advisable to
# have the key embedded like this because if you check this file into source
# control you are publishing the private key to whomever can access the source
# code.
# *******

gcompute_ssl_certificate { 'sample-certificate':
  ensure      => present,
  description => 'A certificate for test purposes only.',
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
  certificate => '-----BEGIN CERTIFICATE-----
MIICqjCCAk+gAwIBAgIJAIuJ+0352Kq4MAoGCCqGSM49BAMCMIGwMQswCQYDVQQG
EwJVUzETMBEGA1UECAwKV2FzaGluZ3RvbjERMA8GA1UEBwwIS2lya2xhbmQxFTAT
BgNVBAoMDEdvb2dsZSwgSW5jLjEeMBwGA1UECwwVR29vZ2xlIENsb3VkIFBsYXRm
b3JtMR8wHQYDVQQDDBZ3d3cubXktc2VjdXJlLXNpdGUuY29tMSEwHwYJKoZIhvcN
AQkBFhJuZWxzb25hQGdvb2dsZS5jb20wHhcNMTcwNjI4MDQ1NjI2WhcNMjcwNjI2
MDQ1NjI2WjCBsDELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xETAP
BgNVBAcMCEtpcmtsYW5kMRUwEwYDVQQKDAxHb29nbGUsIEluYy4xHjAcBgNVBAsM
FUdvb2dsZSBDbG91ZCBQbGF0Zm9ybTEfMB0GA1UEAwwWd3d3Lm15LXNlY3VyZS1z
aXRlLmNvbTEhMB8GCSqGSIb3DQEJARYSbmVsc29uYUBnb29nbGUuY29tMFkwEwYH
KoZIzj0CAQYIKoZIzj0DAQcDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ
4mzkzTv0dXyB750fOGN02HtkpBOZzzvUARTR10JQoSe2/5PIwaNQME4wHQYDVR0O
BBYEFKIQC3A2SDpxcdfn0YLKineDNq/BMB8GA1UdIwQYMBaAFKIQC3A2SDpxcdfn
0YLKineDNq/BMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSQAwRgIhALs4vy+O
M3jcqgA4fSW/oKw6UJxp+M6a+nGMX+UJR3YgAiEAvvl39QRVAiv84hdoCuyON0lJ
zqGNhIPGq2ULqXKK8BY=
-----END CERTIFICATE-----',
  private_key => '-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIObtRo8tkUqoMjeHhsOh2ouPpXCgBcP+EDxZCB/tws15oAoGCCqGSM49
AwEHoUQDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ4mzkzTv0dXyB750f
OGN02HtkpBOZzzvUARTR10JQoSe2/5PIwQ==
-----END EC PRIVATE KEY-----',
}

```

#### `gcompute_subnetwork`

```puppet
# Subnetwork requires a network and a region, so define them in your manifest:
#   - gcompute_network { 'my-network': ensure => presnet }
#   - gcompute_region { 'some-region': ensure => present }
gcompute_subnetwork { 'servers':
  ensure        => present,
  ip_cidr_range => '172.16.0.0/16',
  network       => 'my-network',
  region        => 'some-region',
  project       => 'google.com:graphite-playground',
  credential    => 'mycred',
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
* [`gcompute_backend_bucket`][]:
    Backend buckets allow you to use Google Cloud Storage buckets with
    HTTP(S)
    load balancing.
    An HTTP(S) load balancing can direct traffic to specified URLs to a
    backend bucket rather than a backend service. It can send requests for
    static content to a Cloud Storage bucket and requests for dynamic
    content
    a virtual machine instance.
* [`gcompute_backend_service`][]:
    Creates a BackendService resource in the specified project using the
    data
    included in the request.
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
* [`gcompute_http_health_check`][]:
    An HttpHealthCheck resource. This resource defines a template for how
    individual VMs should be checked for health, via HTTP.
* [`gcompute_https_health_check`][]:
    An HttpsHealthCheck resource. This resource defines a template for how
    individual VMs should be checked for health, via HTTPS.
* [`gcompute_health_check`][]:
    An HealthCheck resource. This resource defines a template for how
    individual virtual machines should be checked for health, via one of
    the supported protocols.
* [`gcompute_license`][]:
    A License resource represents a software license. Licenses are used to
    track software usage in images, persistent disks, snapshots, and
    virtual
    machine instances.
* [`gcompute_image`][]:
    Represents an Image resource.
    Google Compute Engine uses operating system images to create the root
    persistent disks for your instances. You specify an image when you
    create
    an instance. Images contain a boot loader, an operating system, and a
    root file system. Linux operating system images are also capable of
    running containers on Compute Engine.
    Images can be either public or custom.
    Public images are provided and maintained by Google, open-source
    communities, and third-party vendors. By default, all projects have
    access to these images and can use them to create instances.  Custom
    images are available only to your project. You can create a custom
    image
    from root persistent disks and other images. Then, use the custom image
    to create an instance.
* [`gcompute_instance`][]:
    An instance is a virtual machine (VM) hosted on Google's
    infrastructure.
* [`gcompute_instance_group`][]:
    Represents an Instance Group resource. Instance groups are self-managed
    and can contain identical or different instances. Instance groups do
    not
    use an instance template. Unlike managed instance groups, you must
    create
    and add instances to an instance group manually.
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
* [`gcompute_route`][]:
    Represents a Route resource.
    A route is a rule that specifies how certain packets should be handled
    by
    the virtual network. Routes are associated with virtual machines by
    tag,
    and the set of routes for a particular virtual machine is called its
    routing table. For each packet leaving a virtual machine, the system
    searches that virtual machine's routing table for a single best
    matching
    route.
    Routes match packets by destination IP address, preferring smaller or
    more
    specific ranges over larger ones. If there is a tie, the system selects
    the route with the smallest priority value. If there is still a tie, it
    uses the layer three and four packet headers to select just one of the
    remaining matching routes. The packet is then forwarded as specified by
    the next_hop field of the winning route -- either to another virtual
    machine destination, a virtual machine gateway or a Compute
    Engine-operated gateway. Packets that do not match any route in the
    sending virtual machine's routing table will be dropped.
    A Routes resources must have exactly one specification of either
    nextHopGateway, nextHopInstance, nextHopIp, or nextHopVpnTunnel.
* [`gcompute_ssl_certificate`][]:
    An SslCertificate resource. This resource provides a mechanism to
    upload
    an SSL key and certificate to the load balancer to serve secure
    connections from the user.
* [`gcompute_subnetwork`][]:
    A VPC network is a virtual version of the traditional physical networks
    that exist within and between physical data centers. A VPC network
    provides connectivity for your Compute Engine virtual machine (VM)
    instances, Container Engine containers, App Engine Flex services, and
    other network-related resources.
    Each GCP project contains one or more VPC networks. Each VPC network is
    a
    global entity spanning all GCP regions. This global VPC network allows
    VM
    instances and other resources to communicate with each other via
    internal,
    private IP addresses.
    Each VPC network is subdivided into subnets, and each subnet is
    contained
    within a single region. You can have more than one subnet in a region
    for
    a given VPC network. Each subnet has a contiguous private RFC1918 IP
    space. You create instances, containers, and the like in these subnets.
    When you create an instance, you must create it in a subnet, and the
    instance draws its internal IP address from that subnet.
    Virtual machine (VM) instances in a VPC network can communicate with
    instances in all other subnets of the same VPC network, regardless of
    region, using their RFC1918 private IP addresses. You can isolate
    portions
    of the network, even entire subnets, using firewall rules.

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

#### `gcompute_backend_bucket`

Backend buckets allow you to use Google Cloud Storage buckets with HTTP(S)
load balancing.

An HTTP(S) load balancing can direct traffic to specified URLs to a
backend bucket rather than a backend service. It can send requests for
static content to a Cloud Storage bucket and requests for dynamic content
a virtual machine instance.


#### Example

```puppet
gcompute_backend_bucket { 'be-bucket-connection':
  ensure      => present,
  bucket_name => 'backend-bucket-test',
  description => 'A BackendBucket to connect LNB w/ Storage Bucket',
  enable_cdn  => true,
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
}

```

##### `bucket_name`

  Cloud Storage bucket name.

##### `description`

  An optional textual description of the resource; provided by the
  client when the resource is created.

##### `enable_cdn`

  If true, enable Cloud CDN for this BackendBucket.

##### `id`

  Unique identifier for the resource.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

#### `gcompute_backend_service`

Creates a BackendService resource in the specified project using the data
included in the request.


#### Example

```puppet
# Backend Service requires various other services to be setup beforehand. Please
# make sure they are defined as well:
#   - gcompute_instance_group { ... }
#   - Health check
gcompute_backend_service { 'my-app-backend':
  ensure        => present,
  backends      => [
    { group => 'my-puppet-masters' },
  ],
  enable_cdn    => true,
  health_checks => [
    $my_health_check,
  ],
  project       => 'google.com:graphite-playground',
  credential    => 'mycred',
}

```

##### `affinity_cookie_ttl_sec`

  Lifetime of cookies in seconds if session_affinity is
  GENERATED_COOKIE. If set to 0, the cookie is non-persistent and lasts
  only until the end of the browser session (or equivalent). The
  maximum allowed value for TTL is one day.
  When the load balancing scheme is INTERNAL, this field is not used.

##### `backends`

  The list of backends that serve this BackendService.

##### `cdn_policy`

  Cloud CDN configuration for this BackendService.

##### `connection_draining`

  Settings for connection draining

##### `description`

  An optional description of this resource.

##### `enable_cdn`

  If true, enable Cloud CDN for this BackendService.
  When the load balancing scheme is INTERNAL, this field is not used.

##### `health_checks`

  The list of URLs to the HttpHealthCheck or HttpsHealthCheck resource
  for health checking this BackendService. Currently at most one health
  check can be specified, and a health check is required.
  For internal load balancing, a URL to a HealthCheck resource must be
  specified instead.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

##### `port_name`

  Name of backend port. The same name should appear in the instance
  groups referenced by this service. Required when the load balancing
  scheme is EXTERNAL.
  When the load balancing scheme is INTERNAL, this field is not used.

##### `protocol`

  The protocol this BackendService uses to communicate with backends.
  Possible values are HTTP, HTTPS, TCP, and SSL. The default is HTTP.
  For internal load balancing, the possible values are TCP and UDP, and
  the default is TCP.

##### `region`

  A reference to Region resource

##### `session_affinity`

  Type of session affinity to use. The default is NONE.
  When the load balancing scheme is EXTERNAL, can be NONE, CLIENT_IP, or
  GENERATED_COOKIE.
  When the load balancing scheme is INTERNAL, can be NONE, CLIENT_IP,
  CLIENT_IP_PROTO, or CLIENT_IP_PORT_PROTO.
  When the protocol is UDP, this field is not used.

##### `timeout_sec`

  How many seconds to wait for the backend before considering it a
  failed request. Default is 30 seconds. Valid range is [1, 86400].


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource.

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

#### `gcompute_http_health_check`

An HttpHealthCheck resource. This resource defines a template for how
individual VMs should be checked for health, via HTTP.


#### Example

```puppet
gcompute_http_health_check { 'my-app-http-hc':
  ensure              => present,
  healthy_threshold   => 10,
  port                => 8080,
  timeout_sec         => 2,
  unhealthy_threshold => 5,
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

##### `check_interval_sec`

  How often (in seconds) to send a health check. The default value is 5
  seconds.

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `healthy_threshold`

  A so-far unhealthy instance will be marked healthy after this many
  consecutive successes. The default value is 2.

##### `host`

  The value of the host header in the HTTP health check request. If
  left empty (default value), the public IP on behalf of which this
  health check is performed will be used.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

##### `port`

  The TCP port number for the HTTP health check request.
  The default value is 80.

##### `request_path`

  The request path of the HTTP health check request.
  The default value is /.

##### `timeout_sec`

  How long (in seconds) to wait before claiming failure.
  The default value is 5 seconds.  It is invalid for timeoutSec to have
  greater value than checkIntervalSec.

##### `unhealthy_threshold`

  A so-far healthy instance will be marked unhealthy after this many
  consecutive failures. The default value is 2.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource. This identifier is defined by
  the server.

#### `gcompute_https_health_check`

An HttpsHealthCheck resource. This resource defines a template for how
individual VMs should be checked for health, via HTTPS.


#### Example

```puppet
gcompute_https_health_check { 'my-app-https-hc':
  ensure              => present,
  healthy_threshold   => 10,
  port                => 8080,
  timeout_sec         => 2,
  unhealthy_threshold => 5,
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

##### `check_interval_sec`

  How often (in seconds) to send a health check. The default value is 5
  seconds.

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `healthy_threshold`

  A so-far unhealthy instance will be marked healthy after this many
  consecutive successes. The default value is 2.

##### `host`

  The value of the host header in the HTTPS health check request. If
  left empty (default value), the public IP on behalf of which this
  health check is performed will be used.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

##### `port`

  The TCP port number for the HTTPS health check request.
  The default value is 80.

##### `request_path`

  The request path of the HTTPS health check request.
  The default value is /.

##### `timeout_sec`

  How long (in seconds) to wait before claiming failure.
  The default value is 5 seconds.  It is invalid for timeoutSec to have
  greater value than checkIntervalSec.

##### `unhealthy_threshold`

  A so-far healthy instance will be marked unhealthy after this many
  consecutive failures. The default value is 2.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource. This identifier is defined by
  the server.

#### `gcompute_health_check`

An HealthCheck resource. This resource defines a template for how individual virtual machines should be checked for health, via one of the supported protocols.

#### Example

```puppet
gcompute_health_check { 'my-app-tcp-hc':
  ensure              => present,
  type                => 'TCP',
  tcp_health_check    => {
    port_name => 'service-health',
    request   => 'ping',
    response  => 'pong',
  },
  healthy_threshold   => 10,
  timeout_sec         => 2,
  unhealthy_threshold => 5,
  project             => 'google.com:graphite-playground',
  credential          => 'mycred',
}

```

##### `check_interval_sec`

  How often (in seconds) to send a health check. The default value is 5
  seconds.

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `healthy_threshold`

  A so-far unhealthy instance will be marked healthy after this many
  consecutive successes. The default value is 2.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

##### `timeout_sec`

  How long (in seconds) to wait before claiming failure.
  The default value is 5 seconds.  It is invalid for timeoutSec to have
  greater value than checkIntervalSec.

##### `unhealthy_threshold`

  A so-far healthy instance will be marked unhealthy after this many
  consecutive failures. The default value is 2.

##### `type`

  Specifies the type of the healthCheck, either TCP, SSL, HTTP or
  HTTPS. If not specified, the default is TCP. Exactly one of the
  protocol-specific health check field must be specified, which must
  match type field.

##### `http_health_check`

  A nested object resource

##### `https_health_check`

  A nested object resource

##### `tcp_health_check`

  A nested object resource

##### `ssl_health_check`

  A nested object resource


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource. This identifier is defined by
  the server.

#### `gcompute_license`

A License resource represents a software license. Licenses are used to
track software usage in images, persistent disks, snapshots, and virtual
machine instances.


#### Example

```puppet
gcompute_license { 'test-license':
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

```


##### Output-only properties

* `name`: Output only.
  Name of the resource. The name is 1-63 characters long
  and complies with RFC1035.

* `charges_use_fee`: Output only.
  If true, the customer will be charged license fee for
  running software that contains this license on an instance.

#### `gcompute_image`

Represents an Image resource.

Google Compute Engine uses operating system images to create the root
persistent disks for your instances. You specify an image when you create
an instance. Images contain a boot loader, an operating system, and a
root file system. Linux operating system images are also capable of
running containers on Compute Engine.

Images can be either public or custom.

Public images are provided and maintained by Google, open-source
communities, and third-party vendors. By default, all projects have
access to these images and can use them to create instances.  Custom
images are available only to your project. You can create a custom image
from root persistent disks and other images. Then, use the custom image
to create an instance.


#### Example

```puppet
# Tip: Be sure to include a valid gcompute_disk object
gcompute_image { 'test-image':
  ensure      => present,
  source_disk => 'data-disk-1',
  project     => 'google.com:graphite-playground',
  credential  => 'mycred'
}

```

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `disk_size_gb`

  Size of the image when restored onto a persistent disk (in GB).

##### `family`

  The name of the image family to which this image belongs. You can
  create disks by specifying an image family instead of a specific
  image name. The image family always returns its latest image that is
  not deprecated. The name of the image family must comply with
  RFC1035.

##### `guest_os_features`

  A list of features to enable on the guest OS. Applicable for
  bootable images only. Currently, only one feature can be enabled,
  VIRTIO_SCSI_MULTIQUEUE, which allows each virtual CPU to have its
  own queue. For Windows images, you can only enable
  VIRTIO_SCSI_MULTIQUEUE on images with driver version 1.2.0.1621 or
  higher. Linux images with kernel versions 3.17 and higher will
  support VIRTIO_SCSI_MULTIQUEUE.
  For new Windows images, the server might also populate this field
  with the value WINDOWS, to indicate that this is a Windows image.
  This value is purely informational and does not enable or disable
  any features.

##### `image_encryption_key`

  Encrypts the image using a customer-supplied encryption key.
  After you encrypt an image with a customer-supplied key, you must
  provide the same key if you use the image later (e.g. to create a
  disk from the image)

##### `licenses`

  Any applicable license URI.

##### `name`

  Name of the resource; provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

##### `raw_disk`

  The parameters of the raw disk image.

##### `source_disk`

  A reference to Disk resource

##### `source_disk_encryption_key`

  The customer-supplied encryption key of the source disk. Required if
  the source disk is protected by a customer-supplied encryption key.

##### `source_disk_id`

  The ID value of the disk used to create this image. This value may
  be used to determine whether the image was taken from the current
  or a previous instance of a given disk name.

##### `source_type`

  The type of the image used to create this disk. The default and
  only value is RAW


##### Output-only properties

* `archive_size_bytes`: Output only.
  Size of the image tar.gz archive stored in Google Cloud Storage (in
  bytes).

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `deprecated`: Output only.
  The deprecation status associated with this image.

* `id`: Output only.
  The unique identifier for the resource. This identifier
  is defined by the server.

#### `gcompute_instance`

An instance is a virtual machine (VM) hosted on Google's infrastructure.


#### Example

```puppet
# Tip: Remember to define gsql_disk to match the 'disk' property.
# Tip: Remember to define gsql_network to match the 'network' property.
gcompute_instance { 'instance-test':
  ensure             => present,
  machine_type       => 'https://www.googleapis.com/compute/v1/projects/google.com:graphite-playground/zones/us-central1-a/machineTypes/n1-standard-1',
  disks              => [
    {
      boot   => true,
      source => 'data-disk-1'
    }
  ],
  network_interfaces => [
    {
      network => 'mynetwork-test',
    }
  ],
  zone               => 'us-central1-a',
  project            => 'google.com:graphite-playground',
  credential         => 'mycred',
}

```

##### `can_ip_forward`

  Allows this instance to send and receive packets with non-matching
  destination or source IPs. This is required if you plan to use this
  instance to forward routes.

##### `disks`

  Persistent disks are durable storage devices that function similarly
  to the physical disks in a desktop or a server. Compute Engine manages
  the hardware behind these devices to ensure data redundancy and
  optimize performance for you. Persistent disks are available as either
  standard hard disk drives (HDD) or solid-state drives (SSD).

##### `guest_accelerators`

  List of the type and count of accelerator cards attached to the
  instance

##### `label_fingerprint`

  A fingerprint for this request, which is essentially a hash of the
  metadata's contents and used for optimistic locking. The fingerprint
  is initially generated by Compute Engine and changes after every
  request to modify or update metadata. You must always provide an
  up-to-date fingerprint hash in order to update or change metadata.

##### `machine_type`

  Full or partial URL of the machine type resource to use
  for this instance, in the format:
  zones/zone/machineTypes/machine-type. This is provided by the client
  when the instance is created.

##### `min_cpu_platform`

  Specifies a minimum CPU platform for the VM instance. Applicable
  values are the friendly names of CPU platforms

##### `name`

  The name of the resource, provided by the client when initially
  creating the resource. The resource name must be 1-63 characters long,
  and comply with RFC1035. Specifically, the name must be 1-63
  characters long and match the regular expression
  [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a
  lowercase letter, and all following characters must be a dash,
  lowercase letter, or digit, except the last character, which cannot
  be a dash.

##### `network_interfaces`

  An array of configurations for this interface. This specifies how this
  interface is configured to interact with other network services, such
  as connecting to the internet. Only one network interface is supported
  per instance.

##### `scheduling`

  Sets the scheduling options for this instance.

##### `service_accounts`

  A list of service accounts, with their specified scopes, authorized
  for this instance. Only one service account per VM instance is
  supported.

##### `tags`

  A list of tags to apply to this instance. Tags are used to identify
  valid sources or targets for network firewalls and are specified by
  the client during instance creation. The tags can be later modified
  by the setTags method. Each tag within the list must comply with
  RFC1035.

##### `zone`

Required.  URL of the zone where the disk type resides.


##### Output-only properties

* `cpu_platform`: Output only.
  The CPU platform used by this instance.

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource. This identifier is defined by
  the server.

* `status`: Output only.
  The status of the instance. One of the following values:
  PROVISIONING, STAGING, RUNNING, STOPPING, SUSPENDING, SUSPENDED,
  and TERMINATED.

* `status_message`: Output only.
  An optional, human-readable explanation of the status.

#### `gcompute_instance_group`

Represents an Instance Group resource. Instance groups are self-managed
and can contain identical or different instances. Instance groups do not
use an instance template. Unlike managed instance groups, you must create
and add instances to an instance group manually.


#### Example

```puppet
# Instance group requires a network, so define them in your manifest:
#   - gcompute_network { 'my-network': ensure => present }
gcompute_instance_group { 'my-puppet-masters':
  ensure      => present,
  named_ports => [
    {
      name => 'puppet',
      port => 8140,
    },
  ],
  network     => 'my-network',
  zone        => 'us-central1-a',
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
}

```

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource.

##### `name`

  The name of the instance group.
  The name must be 1-63 characters long, and comply with RFC1035.

##### `named_ports`

  Assigns a name to a port number.
  For example: {name: "http", port: 80}.
  This allows the system to reference ports by the assigned name
  instead of a port number. Named ports can also contain multiple
  ports.
  For example: [{name: "http", port: 80},{name: "http", port: 8080}]
  Named ports apply to all instances in this instance group.

##### `network`

  A reference to Network resource

##### `region`

  A reference to Region resource

##### `subnetwork`

  A reference to Subnetwork resource

##### `zone`

Required.  URL of the zone where the autoscaler resides.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  A unique identifier for this instance group.

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

#### `gcompute_route`

Represents a Route resource.

A route is a rule that specifies how certain packets should be handled by
the virtual network. Routes are associated with virtual machines by tag,
and the set of routes for a particular virtual machine is called its
routing table. For each packet leaving a virtual machine, the system
searches that virtual machine's routing table for a single best matching
route.

Routes match packets by destination IP address, preferring smaller or more
specific ranges over larger ones. If there is a tie, the system selects
the route with the smallest priority value. If there is still a tie, it
uses the layer three and four packet headers to select just one of the
remaining matching routes. The packet is then forwarded as specified by
the next_hop field of the winning route -- either to another virtual
machine destination, a virtual machine gateway or a Compute
Engine-operated gateway. Packets that do not match any route in the
sending virtual machine's routing table will be dropped.

A Routes resources must have exactly one specification of either
nextHopGateway, nextHopInstance, nextHopIp, or nextHopVpnTunnel.


#### Example

```puppet
# Subnetwork requires a network and a region, so define them in your manifest:
#   - gcompute_network { 'my-network': ensure => presnet }
#   - gcompute_region { 'some-region': ensure => present }
gcompute_route { 'corp-route':
  ensure           => present,
  dest_range       => '192.168.6.0/24',
  next_hop_gateway => 'global/gateways/default-internet-gateway',
  network          => 'my-network',
  tags             => ['backends', 'databases'],
  project          => 'google.com:graphite-playground',
  credential       => 'mycred',
}

```

##### `dest_range`

  The destination range of outgoing packets that this route applies to.
  Only IPv4 is supported.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

##### `network`

  A reference to Network resource

##### `priority`

  The priority of this route. Priority is used to break ties in cases
  where there is more than one matching route of equal prefix length.
  In the case of two routes with equal prefix length, the one with the
  lowest-numbered priority value wins.
  Default value is 1000. Valid range is 0 through 65535.

##### `tags`

  A list of instance tags to which this route applies.

##### `next_hop_gateway`

  URL to a gateway that should handle matching packets.
  Currently, you can only specify the internet gateway, using a full or
  partial valid URL:
  * https://www.googleapis.com/compute/v1/projects/project/
  global/gateways/default-internet-gateway
  * projects/project/global/gateways/default-internet-gateway
  * global/gateways/default-internet-gateway

##### `next_hop_instance`

  URL to an instance that should handle matching packets.
  You can specify this as a full or partial URL. For example:
  * https://www.googleapis.com/compute/v1/projects/project/zones/zone/
  instances/instance
  * projects/project/zones/zone/instances/instance
  * zones/zone/instances/instance

##### `next_hop_ip`

  Network IP address of an instance that should handle matching packets.

##### `next_hop_vpn_tunnel`

  URL to a VpnTunnel that should handle matching packets.


#### `gcompute_ssl_certificate`

An SslCertificate resource. This resource provides a mechanism to upload
an SSL key and certificate to the load balancer to serve secure
connections from the user.


#### Example

```puppet
# *******
# WARNING: This manifest is for example purposes only. It is *not* advisable to
# have the key embedded like this because if you check this file into source
# control you are publishing the private key to whomever can access the source
# code.
# *******

gcompute_ssl_certificate { 'sample-certificate':
  ensure      => present,
  description => 'A certificate for test purposes only.',
  project     => 'google.com:graphite-playground',
  credential  => 'mycred',
  certificate => '-----BEGIN CERTIFICATE-----
MIICqjCCAk+gAwIBAgIJAIuJ+0352Kq4MAoGCCqGSM49BAMCMIGwMQswCQYDVQQG
EwJVUzETMBEGA1UECAwKV2FzaGluZ3RvbjERMA8GA1UEBwwIS2lya2xhbmQxFTAT
BgNVBAoMDEdvb2dsZSwgSW5jLjEeMBwGA1UECwwVR29vZ2xlIENsb3VkIFBsYXRm
b3JtMR8wHQYDVQQDDBZ3d3cubXktc2VjdXJlLXNpdGUuY29tMSEwHwYJKoZIhvcN
AQkBFhJuZWxzb25hQGdvb2dsZS5jb20wHhcNMTcwNjI4MDQ1NjI2WhcNMjcwNjI2
MDQ1NjI2WjCBsDELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xETAP
BgNVBAcMCEtpcmtsYW5kMRUwEwYDVQQKDAxHb29nbGUsIEluYy4xHjAcBgNVBAsM
FUdvb2dsZSBDbG91ZCBQbGF0Zm9ybTEfMB0GA1UEAwwWd3d3Lm15LXNlY3VyZS1z
aXRlLmNvbTEhMB8GCSqGSIb3DQEJARYSbmVsc29uYUBnb29nbGUuY29tMFkwEwYH
KoZIzj0CAQYIKoZIzj0DAQcDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ
4mzkzTv0dXyB750fOGN02HtkpBOZzzvUARTR10JQoSe2/5PIwaNQME4wHQYDVR0O
BBYEFKIQC3A2SDpxcdfn0YLKineDNq/BMB8GA1UdIwQYMBaAFKIQC3A2SDpxcdfn
0YLKineDNq/BMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSQAwRgIhALs4vy+O
M3jcqgA4fSW/oKw6UJxp+M6a+nGMX+UJR3YgAiEAvvl39QRVAiv84hdoCuyON0lJ
zqGNhIPGq2ULqXKK8BY=
-----END CERTIFICATE-----',
  private_key => '-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIObtRo8tkUqoMjeHhsOh2ouPpXCgBcP+EDxZCB/tws15oAoGCCqGSM49
AwEHoUQDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ4mzkzTv0dXyB750f
OGN02HtkpBOZzzvUARTR10JQoSe2/5PIwQ==
-----END EC PRIVATE KEY-----',
}

```

##### `certificate`

  The certificate in PEM format.
  The certificate chain must be no greater than 5 certs long.
  The chain must include at least one intermediate cert.

##### `description`

  An optional description of this resource.

##### `name`

  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

##### `private_key`

  The private key in PEM format.


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource.

#### `gcompute_subnetwork`

A VPC network is a virtual version of the traditional physical networks
that exist within and between physical data centers. A VPC network
provides connectivity for your Compute Engine virtual machine (VM)
instances, Container Engine containers, App Engine Flex services, and
other network-related resources.

Each GCP project contains one or more VPC networks. Each VPC network is a
global entity spanning all GCP regions. This global VPC network allows VM
instances and other resources to communicate with each other via internal,
private IP addresses.

Each VPC network is subdivided into subnets, and each subnet is contained
within a single region. You can have more than one subnet in a region for
a given VPC network. Each subnet has a contiguous private RFC1918 IP
space. You create instances, containers, and the like in these subnets.
When you create an instance, you must create it in a subnet, and the
instance draws its internal IP address from that subnet.

Virtual machine (VM) instances in a VPC network can communicate with
instances in all other subnets of the same VPC network, regardless of
region, using their RFC1918 private IP addresses. You can isolate portions
of the network, even entire subnets, using firewall rules.


#### Example

```puppet
# Subnetwork requires a network and a region, so define them in your manifest:
#   - gcompute_network { 'my-network': ensure => presnet }
#   - gcompute_region { 'some-region': ensure => present }
gcompute_subnetwork { 'servers':
  ensure        => present,
  ip_cidr_range => '172.16.0.0/16',
  network       => 'my-network',
  region        => 'some-region',
  project       => 'google.com:graphite-playground',
  credential    => 'mycred',
}

```

##### `description`

  An optional description of this resource. Provide this property when
  you create the resource. This field can be set only at resource
  creation time.

##### `gateway_address`

  The gateway address for default routes to reach destination addresses
  outside this subnetwork. This field can be set only at resource
  creation time.

##### `ip_cidr_range`

  The range of internal addresses that are owned by this subnetwork.
  Provide this property when you create the subnetwork. For example,
  10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
  non-overlapping within a network. Only IPv4 is supported.

##### `name`

  The name of the resource, provided by the client when initially
  creating the resource. The name must be 1-63 characters long, and
  comply with RFC1035. Specifically, the name must be 1-63 characters
  long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which
  means the first character must be a lowercase letter, and all
  following characters must be a dash, lowercase letter, or digit,
  except the last character, which cannot be a dash.

##### `network`

  A reference to Network resource

##### `private_ip_google_access`

  Whether the VMs in this subnet can access Google services without
  assigned external IP addresses.

##### `region`

Required.  A reference to Region resource


##### Output-only properties

* `creation_timestamp`: Output only.
  Creation timestamp in RFC3339 text format.

* `id`: Output only.
  The unique identifier for the resource.


## Limitations

This module has been tested on:

* RedHat 6, 7
* CentOS 6, 7
* Debian 7, 8
* Ubuntu 12.04, 14.04, 16.04, 16.10
* SLES 11-sp4, 12-sp2
* openSUSE 13
* Windows Server 2008 R2, 2012 R2, 2012 R2 Core, 2016 R2, 2016 R2 Core

Testing on other platforms has been minimal and cannot be guaranteed.

## Development

### Automatically Generated Files

Some files in this package are automatically generated by puppet-codegen.

We use a code compiler to produce this module in order to avoid repetitive tasks
and improve code quality. This means all Google Cloud Platform Puppet modules
use the same underlying authentication, logic, test generation, style checks,
etc.

Note: Currently `puppet-codegen` is not yet generally available, but it will
be made open source soon. Stay tuned. Please learn more about the way to change
autogenerated files by reading the [CONTRIBUTING.md][] file.

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
`PUPPET_HTTP_VERBOSE=1` | Prints network access information by Puppet provier.
`PUPPET_HTTP_DEBUG=1`   | Prints the payload of network calls being made.
`GOOGLE_HTTP_VERBOSE=1` | Prints debug related to the network calls being made.
`GOOGLE_HTTP_DEBUG=1`   | Prints the payload of network calls being made.

During test runs (using [rspec][]) you can also set:

Variable                | Side Effect
------------------------|---------------------------------------------------
`RSPEC_DEBUG=1`         | Prints debug related to the tests being run.
`RSPEC_HTTP_VERBOSE=1`  | Prints network expectations and access.

[CONTRIBUTING.md]: CONTRIBUTING.md
[`google-gauth`]: https://github.com/GoogleCloudPlatform/puppet-google-auth
[rspec]: http://rspec.info/
[rspec-puppet]: http://rspec-puppet.com/
[rubocop]: https://rubocop.readthedocs.io/en/latest/
[`gcompute_address`]: #gcompute_address
[`gcompute_backend_bucket`]: #gcompute_backend_bucket
[`gcompute_backend_service`]: #gcompute_backend_service
[`gcompute_disk_type`]: #gcompute_disk_type
[`gcompute_disk`]: #gcompute_disk
[`gcompute_firewall`]: #gcompute_firewall
[`gcompute_global_address`]: #gcompute_global_address
[`gcompute_http_health_check`]: #gcompute_http_health_check
[`gcompute_https_health_check`]: #gcompute_https_health_check
[`gcompute_health_check`]: #gcompute_health_check
[`gcompute_license`]: #gcompute_license
[`gcompute_image`]: #gcompute_image
[`gcompute_instance`]: #gcompute_instance
[`gcompute_instance_group`]: #gcompute_instance_group
[`gcompute_network`]: #gcompute_network
[`gcompute_region`]: #gcompute_region
[`gcompute_route`]: #gcompute_route
[`gcompute_ssl_certificate`]: #gcompute_ssl_certificate
[`gcompute_subnetwork`]: #gcompute_subnetwork
