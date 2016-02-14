#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

use HTML::Tidy;
use File::Find::Object::Rule;
use IO::All;

local $SIG{__WARN__} = sub {
    my $w = shift;
    if ($w !~ /\AUse of uninitialized/)
    {
        die $w;
    }
    return;
};

my $tidy = HTML::Tidy->new({ output_xhtml => 1, });
$tidy->ignore( type => TIDY_WARNING, type => TIDY_INFO );

my $error_count = 0;

for my $fn (File::Find::Object::Rule->file()->name(qr/\.x?html\z/)->in("./dest"))
{
    $tidy->parse( $fn, (scalar io->file($fn)->slurp()));

    for my $message ( $tidy->messages ) {
        $error_count++;
        diag( $message->as_string);
    }
}

# TEST
is ($error_count, 0, "No errors");

=head1 COPYRIGHT & LICENSE

Copyright 2016 by Shlomi Fish

This program is distributed under the MIT (X11) License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut
