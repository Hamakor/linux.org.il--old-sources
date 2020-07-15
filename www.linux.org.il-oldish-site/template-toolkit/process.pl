#!/usr/bin/perl

use strict;
use warnings;

use utf8;

use Template           ();
use File::Find::Object ();

use File::Path qw( mkpath );
use File::Spec ();
use File::Copy qw( copy );

my $template = Template->new(
    {
        INCLUDE_PATH => [ "./", "./lib", ],
        POST_CHOMP   => 1,
        RELATIVE     => 1,
        ENCODING     => 'utf8',
    }
);

my $tree = File::Find::Object->new( {}, './src' );

while ( my $result = $tree->next_obj() )
{
    if ( $result->is_dir() )
    {
        mkpath(
            File::Spec->catdir(
                File::Spec->curdir(), "dest",
                @{ $result->full_components() }
            )
        );
    }
    else
    {
        my $basename = $result->basename;
        if ( $basename =~ s/\.html\.tt2\z/.html/ )
        {
            my $base_path =
                ( '../' x scalar( @{ $result->dir_components() } ) );

            my $vars = +{
                base_path => $base_path,
                icon_en =>
qq#<img src="${base_path}icon_lang_en.png" alt="סמל אנגלית" class="symbol" /> #,
                icon_he =>
qq#<img src="${base_path}icon_lang_he.png" alt="סמל עברית" class="symbol" /> #,
            };

            $template->process(
                $result->path(),
                $vars,
                File::Spec->catfile(
                    File::Spec->curdir(),           "dest",
                    @{ $result->dir_components() }, $basename
                ),
                binmode => ':utf8',
            ) or die $template->error();
        }
        elsif ($basename !~ /~\z/
            && ( !( $basename =~ /\A\./ && $basename =~ /\.swp\z/ ) )
            && ( $basename ne 'process.pl' ) )
        {
            copy(
                $result->path,
                File::Spec->catfile(
                    File::Spec->curdir(),           "dest",
                    @{ $result->dir_components() }, $basename
                ),
            );
        }
    }
}
__END__

=head1 COPYRIGHT & LICENSE

Copyright 2019 by Shlomi Fish

This program is distributed under the MIT / Expat License:
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
