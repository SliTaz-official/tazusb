# Makefile for Tazlito.
# Check the README for more information.
#
PREFIX?=/usr
DOCDIR?=/usr/share/doc
DESTDIR?=

all:

# i18n.

pot:
	xgettext -o po/tazusbbox/tazusbbox.pot -L Shell ./tazusbbox

msgmerge:
	msgmerge -U po/tazusbbox/fr.po po/tazusbbox/tazusbbox.pot

msgfmt:
	mkdir -p po/mo/fr
	msgfmt -o po/mo/fr/tazusbbox.mo po/tazusbbox/fr.po

# Installation.

install: msgfmt
	@echo "Installing TazUSB into $(DESTDIR)$(PREFIX)/bin..."
	install -d -m 0777 $(DESTDIR)$(PREFIX)/bin
	install -g root -o root -m 0777 tazusb $(DESTDIR)$(PREFIX)/bin
	install -D -m 0777 tazusbbox $(DESTDIR)$(PREFIX)/bin
	@echo "Installing Tazusb documentation..."
	install -g root -o root -m 0755 -d $(DESTDIR)$(DOCDIR)/tazlito
	install -g root -o root -m 0644 doc/tazusb.en.html $(DESTDIR)$(DOCDIR)/tazlito
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
