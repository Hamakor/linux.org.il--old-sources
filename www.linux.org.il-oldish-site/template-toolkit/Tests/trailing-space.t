#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 1;

use Test::TrailingSpace;

my $finder = Test::TrailingSpace->new(
    {
        root => '.',
        filename_regex => qr/\.(x?html|conf|tt2|pl|md|mak|pm)\z/,
    },
);

# TEST
$finder->no_trailing_space(
    "No trailing space was found."
);
