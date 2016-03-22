# awt

#### Table of Contents
1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with awt](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

Profile and role definitions for the aussieswithtails domain.

## Module Description

The awt module provides a standard set of resources for configuring nodes
within the aussieswithtails domain. These resources include:

* [Profiles](#profiles)
* [Roles](#roles)
* [Types](#types)

## Setup

Installing the awt module makes aussieswithtail specific 
profiles, roles, types and other resources available to puppet.

## Usage

Using the module consists of:

 * Defining specific profiles
 * Assigning one or more profiles to a role
 * Assigning a single role to a node.

For example:
```profile::perforce::server {
        include perforce_server
    }
    
    profile::git::gitolite {
        include gitolite
    }
    
    role::cm_server {
        include profile::perforce::server
        include profile::git::gitolite
    }
    
    node server01 {
        include role::cm_server
    }```


## Reference

### Classes

#### Profile Classes

* [`git::gitolite`](#profile-git::gitolite)

#### Role Classes

#### Types

* [`File_and_mount`](#type-file_and_mount)


##### Profile: `Git::Gitolite`

Install and configure a 
[Gitolite Server](http://gitolite.com/gitolite/index.html) as follows:

* Create a BTRFS subvolume `/@gitolite`.
* Mount the gitolite server at `/srv/gitolite` and add a corresponding
    entry to `/etc/fstab`.
* Create the `gitolite` user and group.
* Add the awt::gitolite::owner ssh-key as the gitolite 
    administrative user.
    
###### Parameters

* `btrfs_device`: The btrs device on which to define the gitolite 
subvolume. Specification can either be of the form `/dev/<this device>` 
or a `uuid`. Required


##### Type: File_and_mount

This type creates a mountpoint, mounts a specified device on that mountpoint,
ensures correct ownership and permissions on the mountpoint and adds an
entry to /etc/fstab. In addition to providing a convenience routine, 
it also works around the potential Puppet `Mount` resource problem of 
not respecting a  mountpoints underlying ownership/permission
(resetting them to root).

    * Note that file_and_mount is a thin wrapper around the standard puppet 
resource types `File` and `Mount`

###### Parameters

* `file_params`: A hash of file parameters to pass to the Puppet `File` 
resource. See the `File` type documentation for a list of keys and 
values.

    * Note: If the `file_params` hash does not include the `path` key, 
    this  `path` attribute defaults to the `file_and_mount` **Namevar**

* `mount_params`:  A hash of mount parameters to pass to the Puppet 
`Mount` resource. See the `Mount` documentation for a list of keys 
and values.

    * Note: If the `mount_params` hash does not include the `name` key, this 
`name` attribute defaults to the `file_and_mount` **Namevar**

    * Note: the `mount_params` hash must *not* include a `requires` or 
`before` parameter specification. Doing so will potentially
result in the mountpoint having the wrong ownership.

## Limitations

## Development

