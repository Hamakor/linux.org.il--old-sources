RSYNC_EXTRA_OPTS =

DESTS = dest/index.html

UPLOAD_URL = hostgator:public_html/temp-www.linux.org.il-new-site/

all: $(DESTS)

$(DESTS): dest/%.html: src/%.html.tt2 footer.tt2 blocks.tt2
	perl process.pl

upload: all
	rsync -a -v --progress --inplace --exclude='**~' --exclude='**/.*.swp' $(RSYNC_EXTRA_OPTS) dest/ $(UPLOAD_URL)
