
FREEDOM_SDK_UTILITIES_GITURL := https://github.com/sifive/freedom-sdk-utilities.git
FREEDOM_SDK_UTILITIES_COMMIT := aa714feb26b7c0390534fa830b793ead06e42196

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_SDK_UTILITIES_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_SDK_UTILITIES := freedom-sdk-utilities
SRCPATH_FREEDOM_SDK_UTILITIES := $(SRCDIR)/$(SRCNAME_FREEDOM_SDK_UTILITIES)

.PHONY: sdk-utilities sdk-utilities-package sdk-utilities-regress sdk-utilities-cleanup sdk-utilities-flushup
sdk-utilities: sdk-utilities-package

$(SRCPATH_FREEDOM_SDK_UTILITIES).$(FREEDOM_SDK_UTILITIES_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_SDK_UTILITIES)
	rm -rf $(SRCPATH_FREEDOM_SDK_UTILITIES).*
	git clone $(FREEDOM_SDK_UTILITIES_GITURL) $(SRCPATH_FREEDOM_SDK_UTILITIES)
	cd $(SRCPATH_FREEDOM_SDK_UTILITIES) && git checkout --detach $(FREEDOM_SDK_UTILITIES_COMMIT)
	cd $(SRCPATH_FREEDOM_SDK_UTILITIES) && git submodule update --init --recursive
	date > $@

sdk-utilities-package: \
		$(SRCPATH_FREEDOM_SDK_UTILITIES).$(FREEDOM_SDK_UTILITIES_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_SDK_UTILITIES) package POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

sdk-utilities-regress: \
		$(SRCPATH_FREEDOM_SDK_UTILITIES).$(FREEDOM_SDK_UTILITIES_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_SDK_UTILITIES) regress POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

sdk-utilities-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_SDK_UTILITIES) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_SDK_UTILITIES).*
	rm -rf $(SRCPATH_FREEDOM_SDK_UTILITIES)

sdk-utilities-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_SDK_UTILITIES) flushup POSTFIXPATH=$(abspath .)/