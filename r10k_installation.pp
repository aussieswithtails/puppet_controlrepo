class { '::r10k':
  version => '2.1.1',
  sources => {
    'puppet' => {
      'remote'  => 'https://github.com/snesbittsea/coderepo.git',
      'basedir' => "${::settings::codedir}/environments",
      'prefix'  => false,
    },
  },
}
