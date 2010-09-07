#!/usr/bin/env perl
use Perl6::Say;
$sum = 0;
while (<>) {
  $sum += $_;
}
say $sum
