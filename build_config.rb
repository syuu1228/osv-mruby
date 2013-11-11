MRuby::Build.new do |conf|
  # load specific toolchain settings
  toolchain :gcc

  # Use standard Kernel#sprintf method
  conf.gem :core => "mruby-sprintf"

  # Use standard print/puts/p
  conf.gem :core => "mruby-print"

  # Use standard Math module
  # conf.gem :core => "mruby-math"  # XXX

  # Use standard Time class
  conf.gem :core => "mruby-time"

  # Use standard Struct class
  conf.gem :core => "mruby-struct"

  # Use extensional Enumerable module
  conf.gem :core => "mruby-enum-ext"

  # Use extensional String class
  conf.gem :core => "mruby-string-ext"

  # Use extensional Numeric class
  conf.gem :core => "mruby-numeric-ext"

  # Use extensional Array class
  conf.gem :core => "mruby-array-ext"

  # Use extensional Hash class
  conf.gem :core => "mruby-hash-ext"

  # Use extensional Range class
  conf.gem :core => "mruby-range-ext"

  # Use extensional Proc class
  conf.gem :core => "mruby-proc-ext"

  # Use extensional Symbol class
  conf.gem :core => "mruby-symbol-ext"

  # Use Random class
  # conf.gem :core => "mruby-random"  # we use "iij/mruby-simple-random"

  # Use extensional Object class
  conf.gem :core => "mruby-object-ext"

  # Use ObjectSpace class
  conf.gem :core => "mruby-objectspace"

  # Use Fiber class
  conf.gem :core => "mruby-fiber"

  # Use extended toplevel object (main) methods
  conf.gem :core => "mruby-toplevel-ext"

  # Use IIJ modules
#  conf.gem :git => 'https://github.com/iij/mruby-digest.git'
  conf.gem :git => 'https://github.com/iij/mruby-dir.git'
  conf.gem :git => 'https://github.com/iij/mruby-env.git'
  conf.gem :git => 'https://github.com/iij/mruby-errno.git'
  conf.gem :git => 'https://github.com/iij/mruby-io.git'
  conf.gem :git => 'https://github.com/iij/mruby-ipaddr.git'
  conf.gem :git => 'https://github.com/iij/mruby-mock.git'
  conf.gem :git => 'https://github.com/iij/mruby-mtest.git'
  conf.gem :git => 'https://github.com/iij/mruby-pack.git'
  conf.gem :git => 'https://github.com/iij/mruby-process.git'
  conf.gem :git => 'https://github.com/iij/mruby-regexp-pcre.git'
  conf.gem :git => 'https://github.com/iij/mruby-require.git'
  conf.gem :git => 'https://github.com/iij/mruby-simple-random.git'
  conf.gem :git => 'https://github.com/syuu1228/osv-mruby-socket.git'
#  conf.gem :git => 'https://github.com/iij/mruby-syslog.git'
  conf.gem :git => 'https://github.com/iij/mruby-tempfile.git'

  conf.gem :git => 'https://github.com/mattn/mruby-http.git'

  conf.gem :git => 'https://github.com/suzukaze/mruby-msgpack.git'

  conf.gem :git => 'https://github.com/mattn/mruby-msgpack-rpc.git'

  conf.gem :git => 'https://github.com/syuu1228/osv-mruby-polarssl.git'

  conf.gem :git => 'https://github.com/mattn/mruby-json.git'

  conf.gem :github => 'mobiruby/mruby-cfunc', :branch => 'master'

  # Generate mirb command
  conf.gem :core => "mruby-bin-mirb"

  # Generate mruby command
  conf.gem :core => "mruby-bin-mruby"

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
