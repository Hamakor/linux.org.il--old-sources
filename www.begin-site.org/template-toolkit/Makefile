RSYNC_EXTRA_OPTS =

DESTS = dest/index.html

UPLOAD_URL = hostgator:domains/begin-site.org

all: $(DESTS)

$(DESTS): dest/%.html: src/%.tt2 footer.tt2 blocks.tt2
	perl process.pl

upload: all
	rsync -a -v --progress --inplace --exclude='**~' --exclude='**/.*.swp' $(RSYNC_EXTRA_OPTS) dest/ $(UPLOAD_URL)
