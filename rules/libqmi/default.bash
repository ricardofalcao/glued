version=\
(
    "1.30.2"
)

url=\
(
    "https://www.freedesktop.org/software/libqmi/libqmi-${version}.tar.xz"
)

md5=\
(
    "c0a656e06dccdd4fcd590f1d718a3b1c"
)

maintainer=\
(
    'Ricardo Falcão <contacto@ricardofalcao.pt>'
)

requires=\
(
    'glib/default'
    'libffi/default'
)

configure()
{
    ./configure \
        --prefix="/usr" \
        --target="$cfg_target_canonical"            \
        --host="$cfg_target_canonical"              \
        --build="$cfg_host_canonical"               \
        --without-udev
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make DESTDIR="$cfg_dir_toolchain_sysroot" install
}

target_install() {
    $cmd_mkdir "$cfg_dir_rootfs/usr/lib"
    $cmd_mkdir "$cfg_dir_rootfs/usr/bin"
    $cmd_mkdir "$cfg_dir_rootfs/usr/libexec"

    # Libs:
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libqmi*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libffi*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libgio*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libgmodule*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libgobject*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libglib*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    $cmd_target_strip -v "$cfg_dir_toolchain_sysroot/usr/bin/qmicli" -o "$cfg_dir_rootfs/usr/bin/qmicli"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/qmi-network" "$cfg_dir_rootfs/usr/bin/qmi-network"
    
    $cmd_target_strip -v "$cfg_dir_toolchain_sysroot/usr/libexec/qmi-proxy" -o "$cfg_dir_rootfs/usr/libexec/qmi-proxy"

    # tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}


