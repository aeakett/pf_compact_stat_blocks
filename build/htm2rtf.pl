#!/usr/bin/perl

use HTML::FormatRTF;

my $out_file = "stat_blocks.rtf";
open(RTF, ">$out_file")
 or die "Can't write-open $out_file: $!\nAborting";
   
print RTF HTML::FormatRTF->format_file(
  'stat_blocks.htm',
    'fontname_headings' => "Verdana",
);
close(RTF);
