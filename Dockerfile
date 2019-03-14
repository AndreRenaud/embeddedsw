FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
    gcc \
    git \
    make \
    wget \
    xz-utils

WORKDIR /tools
# Install the ARM64 toolchain
RUN wget -nv https://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/aarch64-elf/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-elf.tar.xz -O - | tar -C /tools -xJ
# Fix up naming - FSBL wants things name aarch64-none-elf-*, not aarch64-elf-*
RUN cd /tools/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-elf/bin ; ln -s aarch64-elf-gcc aarch64-none-elf-gcc ; ln -s aarch64-elf-ar aarch64-none-elf-ar ; ln -s aarch64-elf-objdump aarch64-none-elf-objdump

# Install the Microblaze toolchain.
# We've got our own copy on DropBox, but it would be good to get this from
# a more authoritative upstream source
RUN wget -nv https://www.dropbox.com/s/ivu7thfhbcujcfg/microblaze-xilinx-elf.tar.gz?dl=0 -O - | tar -C /tools -xz

# Set up the path to include ARM compiler
ENV PATH "/tools/microblaze-xilinx-elf/bin/:/tools/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"


