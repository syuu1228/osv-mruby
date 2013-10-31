include ../../../../module.mk

module: mruby.so mirb.so

mruby-objects = mruby.o libmruby.a libffi_pic.a
mirb-objects = mirb.o libmruby.a libffi_pic.a

define mruby-includes
  build/$(mode)/module/osv-mruby/mruby/src
  build/$(mode)/module/osv-mruby/mruby/include
endef

cflags-mruby-include = $(foreach path, $(strip $(mruby-includes)), -isystem $(src)/$(path))

$(mruby-objects): local-includes += $(cflags-mruby-include)
$(mruby-objects): post-includes-bsd =
$(mruby-objects): kernel-defines =
$(mruby-objects): CFLAGS += -Wno-unknown-pragmas

$(mirb-objects): local-includes += $(cflags-mruby-include)
$(mirb-objects): post-includes-bsd =
$(mirb-objects): kernel-defines =
$(mirb-objects): CFLAGS += -Wno-unknown-pragmas

libmruby.a:
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
