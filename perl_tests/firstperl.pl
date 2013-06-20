#!/bin/perl

use File::Find;
use File::stat;
use strict;
use warnings;
use Digest::MD5 qw(md5_base64);
my $digest = Digest::MD5->new;

my @content;
find( \&wanted, '/tmp/testing');
display ( @content );

exit;

sub wanted {
  push @content, $File::Find::name;
  return;
}

sub display {
	for my $file (@content) {


		#my $filesize = -s "$file";
		my $filesize = stat("$file")->size;
		my $fileatime = stat("$file")->atime;
		my $filemtime = stat("$file")->mtime;
		print '$file = ', $file, "\n";
		print 'filesize = ', $filesize, "\n";
		print 'fileatime = ', $fileatime, "\n";
		print 'filemtime = ', $filemtime, "\n";
		#print $i, "\t", "size: ", $size, "\n";
		my $md5sum = getmd5checksum ("$file");
		print 'md5sum = ', $md5sum, "\n";

	}
}

sub getmd5checksum
{
    my $file = shift;
    if (! -r $file) {
    return "Not readable";
    } else {
    open (FILE, $file) or return"";
    $digest->reset();
    my $fileInfo =  getfileinfo($file);
    $digest->add($fileInfo);
        $digest->addfile(*FILE);
    close (FILE);
    return $digest->b64digest;
    }
}
