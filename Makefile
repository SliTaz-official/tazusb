# Makefile for TazUSB.
# Check the README for more information.
#
PREFIX?=/usr
DOCDIR?=/usr/share/doc
DESTDIR?=
LINGUAS?=fr pt

all:

# i18n.

pot:
	xgettext -o po/tazusbbox/tazusbbox.pot -L Shell ./tazusbbox

msgmerge:
	@for l in $(LINGUAS); do \
		echo -n "Updating $$l po file."; \
		msgmerge -U po/tazusbbox/$$l.po po/tazusbbox/tazusbbox.pot ; \
	done;

msgfmt:
	@for l in $(LINGUAS); do \
		echo "Compiling $$l mo file..."; \
		mkdir -p po/mo/$$l; \
		msgfmt -o po/mo/$$l/tazusbbox.mo po/tazusbbox/$$l.po ; \
	done;

# Installation.

install: msgfmt
	@echo "Installing TazUSB into $(DESTDIR)$(PREFIX)/bin..."
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0777 tazusb $(DESTDIR)$(PREFIX)/bin
	install -m 0777 tazusbbox $(DESTDIR)$(PREFIX)/bin
	@echo "Installing Tazusb documentation..."
	mkdir -p $(DESTDIR)$(DOCDIR)/tazusb
	cp -a doc/* $(DESTDIR)$(DOCDIR)/tazusb
	# i18n
	mkdir -p $(DESTDIR)$(PREFIX)/share/locale
	cp -a po/mo/* $(DESTDIR)$(PREFIX)/share/locale

# Uninstallation and tarball clean-up commands.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/tazusb
	rm -f $(DESTDIR)$(PREFIX)/bin/tazusbbox
	rm -rf $(DESTDIR)$(DOCDIR)/tazusb
	rm -rf $(DESTDIR)$(PREFIX)/share/locale/*/LC_MESSAGES/tazusb*.mo

clean:
	rm -rf _pkg
	rm -rf po/mo
