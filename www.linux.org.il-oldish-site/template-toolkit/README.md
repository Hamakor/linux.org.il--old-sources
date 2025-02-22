These are the sources of https://www.shlomifish.org/temp-www.linux.org.il-new-site/ ,
which are/were the legacy version of https://www.linux.org.il/ which is a Hebrew
portal for Linux and FOSS in Israel.

Around 2019, there were discussions on Israeli FOSS forums (mailing lists and Telegram
forums) to establish a new website. The consensus settled on using
[WordPress](https://en.wikipedia.org/wiki/WordPress) for it, but the new site
was not finalized.

<h2>How to build</h2>

- In order to build the site, type “./gen-helpers” from the command line,
followed by “make”.

- If you get the following error:

```text
$ make
Makefile:3: include.mak: No such file or directory
make: *** No rule to make target `include.mak'.  Stop.
```

Then you need to type "./gen-helpers" first, which is used to list the
files that needs to be updated inside “include.mak”.

- In order to upload it, type “make upload” (but you may need to have
the right permissions).

Dependencies:

On Debian, Ubuntu, and derivatives, type:

    sudo apt-get install libtemplate-perl libfile-find-object-perl

On modern Fedora distributions, type

    sudo dnf install perl-Template-Toolkit perl-File-Find-Object

On RHEL-based distributions (such as Red Hat Enterprise Linux (RHEL), CentOS,
or Scientific Linux) and on Fedora up to 21, type:

    sudo yum install perl-Template-Toolkit perl-File-Find-Object

Elsewhere, consult your distribution's convention for installing packages
or use:

    cpan Template File::Find::Object

<h2>Running the test suite</h2>

To run the test type “make test” (after you have run “./gen-helpers”).
It requires some extra CPAN modules.

<h2>How to edit the source</h2>

For each of the dest/**/*.html files the source is found in src/**/*.html.tt2.
Most of the source is regular XHTML , but Template Toolkit 2 directives can
be used too with “[%” and “%]” markers. See:

<a href="http://www.template-toolkit.org/">http://www.template-toolkit.org/</a>


