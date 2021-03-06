## site.pp ##
# Disable filebucket by default for all File resources:
#http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
#File { backup => false }

  notify{ 'Installing & Configuring r10k': }
  class { '::r10k':
    version => '2.1.1',
    sources => {
      'puppet' => {
        'remote'  => 'https://github.com/aussieswithtails/puppet_controlrepo.git',
        'basedir' => "${::settings::codedir}/environments",
        'prefix'  => false,
      },
    },
  }


