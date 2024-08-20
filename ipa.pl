#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $input_users = shift @ARGV;

sub get_user_array(){
	my $input_users = shift;
	my $responce = `ipa user-show $input_users --all 2>&1`;
	my @result;
	my %hash;
	if ($responce !~ /ERROR/g) {
		@result = split /\n/, $responce;
		for (@result) {
				s/^\s+//;
				my ($key, $value) = split /:/;
				$value =~ s/^\s+//;
				$hash{$key} = $value;
		}
		return %hash;
	} else {
			return %hash;
	}
}

sub user_hash_missig_keys() {
	my $h = shift;
	$$h{"Pager Number"} = "N/A" if !$$h{"Pager Number"};
	$$h{"Org. Unit"} = "N/A" if !$$h{"Org. UniPagert"};
}

my %user_hash = &get_user_array($input_users);
if (%user_hash) {
	&user_hash_missig_keys(\%user_hash);
	for (sort keys %user_hash) {
		print "$_ ===> $user_hash{$_}\n";
		}
	} else {
		print "User $input_users not found\n";
	}
