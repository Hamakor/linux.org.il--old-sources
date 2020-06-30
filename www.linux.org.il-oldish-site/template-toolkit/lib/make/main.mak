RSYNC_EXTRA_OPTS =
SHELL = /bin/bash

include include.mak

HTACCESS_DEST = dest/.htaccess

UPLOAD_URL = hostgator:public_html/temp-www.linux.org.il-new-site/
PRODUCTION_UPLOAD_URL = gnu.hamakor.org.il:/var/www/html/linux.org.il

all: $(DEST_HTMLS) $(HTACCESS_DEST)

PROCESS_SCRIPT = process.pl

$(DEST_HTMLS): dest/%.html: src/%.html.tt2 blocks.tt2 $(SRC_IMAGES) $(PROCESS_SCRIPT)
	perl $(PROCESS_SCRIPT)

$(HTACCESS_DEST): htaccess.conf
	cp -f $< $@

upload: all
	rsync -a -v --progress --inplace --exclude='**~' --exclude='**/.*.swp' $(RSYNC_EXTRA_OPTS) dest/ $(UPLOAD_URL)

upload_production: all
	rsync -a -v --progress --inplace --exclude='**~' --exclude='**/.*.swp' $(RSYNC_EXTRA_OPTS) dest/ $(PRODUCTION_UPLOAD_URL)

test: all
	prove Tests/*.{py,t}
