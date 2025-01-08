_:
{
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.shrinker_enabled=1"
    "zswap.parameters.compressor=lz4"
  ];
}