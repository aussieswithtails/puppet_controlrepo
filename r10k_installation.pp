class { '::r10k':
  sources => {
    'puppet' => {
      'remote'  => 'https://github.com/snesbittsea/coderepo.git',
      'basedir' => "${::settings::codedir}/environments",
      'prefix'  => false,
    },
  },
}
