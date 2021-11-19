version=\
(
    '2.56.1'
)

url=\
(
    "https://download.gnome.org/sources/glib/2.56/glib-${version}.tar.xz"
)

md5=\
(
    '988af38524804ea1ae6bc9a2bad181ff'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libffi/default'
    'gettext/host'
    'zlib/host'
    'python_host/host'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    export glib_cv_stack_grows=no
    export glib_cv_uscore=yes
    export ac_cv_func_posix_getpwuid_r=yes
    export ac_cv_func_posix_getgrgid_r=yes

    ./configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --enable-gtk-doc=no \
        --enable-libmount=no \
        --with-pcre=internal
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
