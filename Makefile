# Makefile for TazUSB.
# Check the README for more information.
#
PREFIX?=/usr
DOCDIR?=/usr/share/doc
DESTDIR?=
LINGUAS?=fr pt

PACKAGE	=	tazusb
VERSION	:=	$(shell grep ^VERSION ${PACKAGE} | cut -d '=' -f 2)
TARBALL	=	$(PACKAGE)-$(VERSION).tar.gz

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
	# Desktop integration
	@echo "Setting up desktop integration..."
	mkdir -p $(DESTDIR)$(PREFIX)/share/applications
	cp -a  applications $(DESTDIR)$(PREFIX)/share/

# Uninstallation and tarball clean-up commands.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/tazusb
	rm -f $(DESTDIR)$(PREFIX)/bin/tazusbbox
	rm -rf $(DESTDIR)$(DOCDIR)/tazusb
	rm -rf $(DESTDIR)$(PREFIX)/share/locale/*/LC_MESSAGES/tazusb*.mo

clean:
	rm -rf _pkg
	rm -rf po/mo

dist-clean:
	rm -rf $(DISTDIR)
	rm -f $(DISTDIR).*
	
# Build tarball and MD5 file for packagin.
dist: dist-clean
	hg archive -t tgz $(TARBALL)
	md5sum $(TARBALL) > $(PACKAGE)-$(VERSION).md5
	

