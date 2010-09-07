#!/usr/bin/env perl
use Perl6::Say;
$sum, $cnt = 0, 0;
while (<>) {
  $cnt++;
  $sum += $_;
}
say $sum / $cnt
