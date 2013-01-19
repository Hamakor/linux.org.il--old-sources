In order to build the site, type “make” from the command line.

In order to upload it, type “make upload” (but you may need to have
the right permissions).

Dependencies:

On Debian, Ubuntu and derivatives type:

    sudo apt-get install libtemplate-perl libfile-find-object-perl

On Mandriva and Mageia type:

    sudo urpmi perl-Template perl-File-Find-Object

Elsewhere, consult your distribution's convention for installing packages
or use

    cpan Template File::Find::Object
