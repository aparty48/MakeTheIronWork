**Make the iron work** - a project that shows what you need to do to use the technologies you need at the hardware level.

This project is not a full-fledged OS, but is of an educational nature.

The project is being written in my free time, and it is also very complex due to the requirement to have a good understanding of the technologies.

## Building
The `./build.sh` script automatically compiles the finished `OS.img` file.

Need instal mtools and edk2-ovmf:

- **Ubuntu / Debian**
```sh
sudo apt update && sudo apt install mtools edk2-ovmf
```
- **Fedora**
```sh
sudo dnf install mtools edk2-ovmf
```
- **Arch Linux**
```sh
sudo pacman -S mtools edk2-ovmf
```

Run building (need cd to root of the project):
```sh
./build.sh
```

## Run on QEMU
```sh
qemu-system-x86_64 -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF.4m.fd -drive file=OS.img,format=raw -m 512 -nographic
```