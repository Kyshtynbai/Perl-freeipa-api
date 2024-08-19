#!/usr/bin/perl

use strict;
use warnings;

my $input_users = shift @ARGV;

sub get_user_array(){
	my $input_users = shift;
	my $responce = `ipa user-show $input_users --all 2>&1`;
	my @result;
	print $responce;
	if ($responce !~ /ERROR/g) {
		return @result = split /\n/, $responce;
	} else {
			return @result;
	}
}

my @test = &get_user_array($input_users);
print "$test[1], $test[2] \n" if @test;
