include ../module.mk

module: mruby.so mirb.so bootfs.manifest usr.manifest

libyaml = libyaml/api.o libyaml/reader.o libyaml/scanner.o libyaml/parser.o libyaml/_loader.o libyaml/writer.o libyaml/emitter.o libyaml/dumper.o
libyaml-flags = -Wno-unused-value -DYAML_VERSION_STRING=\"0.1.4\" -DYAML_VERSION_MAJOR=0 -DYAML_VERSION_MINOR=1 -DYAML_VERSION_PATCH=4

libuv = libuv/fs-poll.o libuv/inet.o libuv/uv-common.o libuv/version.o libuv/unix/async.o libuv/unix/core.o libuv/unix/dl.o libuv/unix/fs.o libuv/unix/getaddrinfo.o libuv/unix/loop-watcher.o libuv/unix/loop.o libuv/unix/pipe.o libuv/unix/poll.o libuv/unix/process.o libuv/unix/signal.o libuv/unix/stream.o libuv/unix/tcp.o libuv/unix/thread.o libuv/unix/threadpool.o libuv/unix/timer.o libuv/unix/tty.o libuv/unix/udp.o libuv/unix/linux-core.o libuv/unix/proctitle.o

mruby-objects = mruby.o libmruby.a libffi_pic.a $(libyaml) $(libuv)
mirb-objects = mirb.o libmruby.a libffi_pic.a $(libyaml) $(libuv)

define mruby-includes
  build/$(mode)/module/osv-mruby/mruby/src
  build/$(mode)/module/osv-mruby/mruby/include
  build/$(mode)/module/osv-mruby/include
  build/$(mode)/module/osv-mruby/libuv
endef

cflags-mruby-include = $(foreach path, $(strip $(mruby-includes)), -isystem $(src)/$(path))

$(mruby-objects): local-includes += $(cflags-mruby-include)
$(mruby-objects): post-includes-bsd =
$(mruby-objects): kernel-defines =
$(mruby-objects): CFLAGS += -Wno-unknown-pragmas $(libyaml-flags)

$(mirb-objects): local-includes += $(cflags-mruby-include)
$(mirb-objects): post-includes-bsd =
$(mirb-objects): kernel-defines =
$(mirb-objects): CFLAGS += -Wno-unknown-pragmas $(libyaml-flags)

libmruby.a:
	git submodule update --init
	cp build_config.rb mruby
	make -C mruby clean
	make -C mruby
	ln -sf mruby/build/host/lib/libmruby.a .

mruby.c: libmruby.a
	ln -sf mruby/mrbgems/mruby-bin-mruby/tools/mruby/mruby.c .

mirb.c: libmruby.a
	ln -sf mruby/mrbgems/mruby-bin-mirb/tools/mirb/mirb.c .

mruby.o: mruby.c
	$(CC) $(CFLAGS) -c $< -o $@

mirb.o: mirb.c
	$(CC) $(CFLAGS) -c $< -o $@

mruby.so: $(mruby-objects)
	$(makedir)
	$(q-build-so)

mirb.so: $(mirb-objects)
	$(makedir)
	$(q-build-so)

bootfs.manifest: mruby.so mirb.so
	echo "/mruby.so: module/osv-mruby/mruby.so" > $@
	echo "/mirb.so: module/osv-mruby/mirb.so" >> $@
	echo "/shell.rb: module/osv-mruby/shell.rb" >> $@

usr.manifest:
	echo "" > $@
