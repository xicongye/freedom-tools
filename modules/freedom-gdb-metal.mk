
FREEDOM_GDB_METAL_GITURL=https://github.com/sifive/freedom-gdb-metal.git
FREEDOM_GDB_METAL_COMMIT=d494866ffcc764a6edda58b801e5e9e55901a900

SRCNAME_FREEDOM_GDB_METAL := freedom-gdb-metal
SRCPATH_FREEDOM_GDB_METAL := $(SRCDIR)/$(SRCNAME_FREEDOM_GDB_METAL)

.PHONY: gdb-metal gdb-metal-package gdb-metal-cleanup
gdb-metal: gdb-metal-package

$(SRCPATH_FREEDOM_GDB_METAL).$(FREEDOM_GDB_METAL_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_GDB_METAL)
	rm -rf $(SRCPATH_FREEDOM_GDB_METAL).*
	git clone $(FREEDOM_GDB_METAL_GITURL) $(SRCPATH_FREEDOM_GDB_METAL)
	cd $(SRCPATH_FREEDOM_GDB_METAL) && git checkout --detach $(FREEDOM_GDB_METAL_COMMIT)
	cd $(SRCPATH_FREEDOM_GDB_METAL) && git submodule update --init --recursive
	date > $@

gdb-metal-package: \
		$(SRCPATH_FREEDOM_GDB_METAL).$(FREEDOM_GDB_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_GDB_METAL) package POSTFIXPATH=$(abspath .)/

gdb-metal-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_GDB_METAL) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_GDB_METAL).*
	rm -rf $(SRCPATH_FREEDOM_GDB_METAL)