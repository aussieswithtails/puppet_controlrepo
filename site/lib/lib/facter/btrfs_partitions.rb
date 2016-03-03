Facter.add('btrfs_partitions') do
  PARTITION_TYPE = 'btrfs'
  PARTITION_FACT_KEY = 'filesystem'
  setcode do
    Hash partitions = Facter.value(:partitions)

    ext4Partitions = partitions.select {|k,v| partitions[k][PARTITION_FACT_KEY] == PARTITION_TYPE }
  end
end