# moz_prover
The prover for [Lumoz Airdrop Event](https://docs.lumoz.org/zkprover-airdrop-event).
```shell
pool_address=moz.asia.zk.work:10010
```

## Release-notes

- moz_prover 1.0.1
  - Add hiveos

- moz_prover 1.0.0
  - First moz_prover version for Lumoz testnet

## Requirements
- OS Version: Ubuntu 20.04 +

- Nvidia Driver Version: 535.54.03 +

## Usage
```shell
Usage: moz_prover [OPTIONS] --mozaddress <MOZADDR> --lumozpool <MOZPOOL>

Options:
      --verbosity <VERBOSITY>      Specify the verbosity of the node [options: 0, 1, 2, 3] [default: 0]
      --custom_name <CUSTOM_NAME>  Specify the custom name of this worker instance [default: myprover]
  -g, --gpu_index <GPU_INDEXES>    Specify gpu index to solve puzzle, all gpus are used by default, eg. -g 0 -g 1 -g 2 ...
      --mozaddress <MOZADDR>       Specify Lumoz address to mine with
      --lumozpool <LUMOZ_POOLS>    Specify the Lumoz pool address that the worker is contributing to
  -h, --help                       Print help
  -V, --version                    Print version
```

## Mining Tutorial

Oneline command to start:
`./moz_prover --lumozpool moz.asia.zk.work:10010 --mozaddress 0xxxx --custom_name myprover`

If you don't know how to have a Lumoz address, check this [post](https://discord.com/channels/984349855617011712/1301815847760957470/1302924757368573994) in our Discord.

After starting mining, search your Lumoz address in the search bar of the [pool](https://zk.work/en/lumoz) to get the running status of your miners.

### On Ubuntu

1. Get a Lumoz wallet address.
2. Download zkwork Nvidia miner: `wget https://github.com/6block/zkwork_moz_prover/releases/download/v1.0.1/moz_prover-v1.0.1_cuda.tar.gz`.
3. Download zkwork AMD miner: `wget https://github.com/6block/zkwork_moz_prover/releases/download/v1.0.1/moz_prover-v1.0.1_ocl.tar.gz`.
4. On Nvidia: `tar -zvxf moz_prover-v1.0.1_cuda.tar.gz && cd moz_prover`, on AMD: `tar -zvxf moz_prover-v1.0.1_ocl.tar.gz && cd moz_prover`.
5. Update your Lumoz address in `inner_prover.sh` and set custom name for mining server.
6. Start mining with `sudo chmod +x run_prover.sh && ./run_prover.sh`.
7. Check mining log with `tail -f prover.log`.

### On HiveOS 

1. Choose your download url for your gpu.
  ```
  DOWNLOAD_URL for Nvidia: https://github.com/6block/zkwork_moz_prover/releases/download/v1.0.1/moz_prover-v1.0.1_cuda.tar.gz
  DOWNLOAD_URL for AMD: https://github.com/6block/zkwork_moz_prover/releases/download/v1.0.1/moz_prover-v1.0.1_ocl.tar.gz
  ```
2. Get a Lumoz wallet address.
3. Add New Flight Sheet with config as follows.

Configuration:
- Installation URL: DOWNLOAD_URL
- Wallet and worker template: %WAL%

3. Start Flight Sheet
