#!/usr/bin/env perl

use warnings;
use strict;

use Errno;

foreach my $err (sort keys (%!)) {
    $! = eval "Errno::$err";
    printf "%20s %4d   %s\n", $err, $! + 0, $!
}
