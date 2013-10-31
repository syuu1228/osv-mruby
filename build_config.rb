MRuby::Build.new do |conf|
  # load specific toolchain settings
  toolchain :gcc

  # include the default GEMs
  conf.gembox 'default'

  conf.gem :github => 'mobiruby/mruby-cfunc', :branch => 'master'

  # C compiler settings
  conf.cc do |cc|
      cc.flags << "-fPIC -std=gnu99 -MD -MP -g -Wall -Wno-pointer-arith -Wformat=0 -D __BSD_VISIBLE=1 -U _FORTIFY_SOURCE -fno-stack-protector  -I. -I../../../../../arch/x64 -I../../../../.. -I../../../../../external/libunwind/include -I../../../../../include -isystem ../../../../../include/glibc-compat -isystem ../../../../../external/gcc.bin/usr/include/c++/4.8.1 -isystem ../../../../../external/gcc.bin/usr/include/c++/4.8.1/x86_64-redhat-linux -isystem ../../../../../external/acpica/source/include -isystem ../../../../../external/misc.bin/usr/include -isystem ../../../../../include/api -isystem ../../../../../include/api/x86_64 -isystem ../../../../../external/gcc.bin/usr/lib/gcc/x86_64-redhat-linux/4.8.1/include -isystem ../../../../../build/release/gen/include -isystem ../../../../../bsd/sys -isystem ../../../../../bsd/ -isystem ../../../../../bsd/sys -isystem ../../../../../bsd/  -D_KERNEL -fno-omit-frame-pointer -DHAVE_ATTR_COLD_LABEL -include ../../../../../compiler/include/intrinsics.hh  -isystem ../../../../../external/openjdk.bin/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.25-2.3.12.3.fc19.x86_64/include  -isystem ../../../../../external/openjdk.bin/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.25-2.3.12.3.fc19.x86_64/include/linux -msse4.1 -O2 -DACPI_MACHINE_WIDTH=64 -DACPI_USE_LOCAL_CACHE   -DCONF_preempt=1  -DCONF_debug_memory=0  -DCONF_logger_debug=0 -nostdinc -D__OSV__ -D__XEN_INTERFACE_VERSION__='0x00030207' -DXEN -DXENHVM -DSMP -D'__FBSDID(__str__)=extern int __bogus__' -D__x86_64__ -I ../../../../../libc/internal -I  ../../../../../libc/arch/x64 -Wno-missing-braces -Wno-parentheses -Wno-unused-but-set-variable -I../include"
    if ENV['BUILD_BIT'] == "64"
      cc.flags << ' -DMRB_INT64'
    end
  end

  # Linker settings
  conf.linker do |linker|
    if ENV['BUILD_BIT'] == "64"
      linker.flags = '-DMRB_INT64'
    end
  end
end
