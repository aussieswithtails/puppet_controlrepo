# Class: bacula::client
#
# This class installs and configures the File Daemon to backup a client system.
#
# Sample Usage:
#
#   class { 'bacula::client': director => 'mydirector.example.com' }
#
class r10ka {
  notify{ 'Installing & Configuring r10k': }


  class { '::r10k':
    version => '2.1.1',
    sources => {
      'puppet' => {
        'remote'  => 'https://github.com/snesbittsea/puppet_controlrepo.git',
        'basedir' => "${::settings::codedir}/environments",
        'prefix'  => false,
      },
    },
  }
}