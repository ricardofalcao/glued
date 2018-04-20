version=\
(
    '2020-12-01'
)

url=\
(
    "http://lsts.pt/glued/rpi-boot-firmware-$version.zip"
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
    'Pedro Gonçalves <pedro@lsts.pt>'
)

md5=\
(
    'f58304d09266b8e470349ada91a41340'
)

target_install()
{
    eval "apt-get install -y libssl-dev bison kmod bc flex"
    $cmd_mkdir "$cfg_dir_rootfs/boot"
    $cmd_cp "../$pkg-$version/"* "$cfg_dir_rootfs/boot/"
    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}