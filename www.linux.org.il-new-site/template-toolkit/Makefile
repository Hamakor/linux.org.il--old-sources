RSYNC_EXTRA_OPTS =

DESTS = dest/get.html dest/index.html dest/sites/sites/index.html dest/whatis.html
HTACCESS_DEST = dest/.htaccess

UPLOAD_URL = hostgator:public_html/temp-www.linux.org.il-new-site/

all: $(DESTS) $(HTACCESS_DEST)

$(DESTS): dest/%.html: src/%.html.tt2 footer.tt2 blocks.tt2
	perl process.pl

$(HTACCESS_DEST): htaccess.conf
	cp -f $< $@

upload: all
	rsync -a -v --progress --inplace --exclude='**~' --exclude='**/.*.swp' $(RSYNC_EXTRA_OPTS) dest/ $(UPLOAD_URL)
