# Makefile for TazUSB.
# Check the README for more information.
#
PREFIX?=/usr
DOCDIR?=/usr/share/doc
DESTDIR?=
LINGUAS?=el fr ja pl pt_BR ru vi zh_CN zh_TW

PACKAGE	=	tazusb
VERSION	:=	$(shell grep ^VERSION ${PACKAGE} | cut -d '=' -f 2)
TARBALL	=	$(PACKAGE)-$(VERSION).tar.gz

all:

# i18n.

pot:
	xgettext -o po/tazusb-box/tazusb-box.pot -L Shell \
		--package-name="TazUSB" \
		--package-version="$(VERSION)" \
		-kaction -ktitle -k_ -k_n -k_p:1,2 \
		./tazusb-box
	xgettext -o po/tazusb/tazusb.pot -L Shell \
		--package-name="TazUSB" \
		-kaction -ktitle -k_ -k_n -k_p:1,2 \
		--package-version="$(VERSION)" \
		./tazusb

msgmerge:
	@for l in $(LINGUAS); do \
		if [ -f "po/tazusb-box/$$l.po" ]; then \
			echo -n "Updating $$l po file."; \
			msgmerge -U po/tazusb-box/$$l.po po/tazusb-box/tazusb-box.pot ; \
		fi;\
		if [ -f "po/tazusb/$$l.po" ]; then \
			echo -n "Updating $$l po file."; \
			msgmerge -U po/tazusb/$$l.po po/tazusb/tazusb.pot ; \
		fi;\
	done;

msgfmt:
	@for l in $(LINGUAS); do \
		if [ -f "po/tazusb-box/$$l.po" ]; then \
			echo "Compiling tazusb-box $$l mo file..."; \
			mkdir -p po/mo/$$l/LC_MESSAGES; \
			msgfmt -o po/mo/$$l/LC_MESSAGES/tazusb-box.mo po/tazusb-box/$$l.po ; \
		fi;\
		if [ -f "po/tazusb/$$l.po" ]; then \
			echo "Compiling tazusb $$l mo file..."; \
			mkdir -p po/mo/$$l/LC_MESSAGES; \
			msgfmt -o po/mo/$$l/LC_MESSAGES/tazusb.mo po/tazusb/$$l.po ; \
		fi;\
	done;

# Installation.

install: msgfmt
	@echo "Installing TazUSB into $(DESTDIR)$(PREFIX)/bin..."
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0755 tazusb $(DESTDIR)$(PREFIX)/bin
	-[ "$(VERSION)" ] && sed -i 's/^VERSION=[0-9].*/VERSION=$(VERSION)/' $(DESTDIR)$(PREFIX)/bin/tazusb
	install -m 0755 tazusb-box $(DESTDIR)$(PREFIX)/bin
	@echo "Installing Tazusb documentation..."
	mkdir -p $(DESTDIR)$(DOCDIR)/tazusb
	cp -a doc/* $(DESTDIR)$(DOCDIR)/tazusb
	# i18n
	mkdir -p $(DESTDIR)$(PREFIX)/share/locale
	cp -a po/mo/* $(DESTDIR)$(PREFIX)/share/locale
	# Desktop integration
	@echo "Setting up desktop integration..."
	mkdir -p $(DESTDIR)$(PREFIX)/share
	cp -a  applications $(DESTDIR)$(PREFIX)/share

# Uninstallation and tarball clean-up commands.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/tazusb
	rm -f $(DESTDIR)$(PREFIX)/bin/tazusb-box
	rm -rf $(DESTDIR)$(DOCDIR)/tazusb
	rm -rf $(DESTDIR)$(PREFIX)/share/locale/*/LC_MESSAGES/tazusb*.mo

clean:
	rm -rf _pkg
	rm -rf po/mo
	rm -f po/*/*~

dist-clean:
	rm -rf $(DISTDIR)
	rm -f $(DISTDIR).*
	
# Build tarball and MD5 file for packaging.
dist: dist-clean
	hg archive -t tgz $(TARBALL)
	md5sum $(TARBALL) > $(PACKAGE)-$(VERSION).md5
	

