package Geo::Query;

use 5.008003;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Geo::Query ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();

our $VERSION = '0.02';

#####  FORWARD
sub Debug($);

#####  GLOBAL
my $package = __PACKAGE__;

sub new {
	my $type = shift;
	my %params = @_;
	my $self = {};

	$self->{'debug' } = $params{'debug'} || 0; # 0, 1, 2

	Debug "$package V$VERSION" if $self->{'debug'};

	bless $self, $type;
}

sub info() {
	my $self = shift;
	my %args = @_;

	my %info = ();
	   $info{'version'} = $VERSION;

	use LWP::Simple;
	my $module_list = get 'http://meta.pg'.
				'ate.net/wiki-reto/index.php?title=Perl_modules_geo-query&printable=yes';

	my @lines = split /\n/, $module_list;
	my $i = 0;
	foreach (@lines) { $i++; last if /BEGIN SECTION 101/; }

	for ($i = $i + 1; $i < $#lines + 1; $i++) {
		chomp $lines[$i];
		last if $lines[$i] =~ /END SECTION 101/;
		$info{'modules'} .= $lines[$i] . "\n" if $lines[$i];
	}

	\%info;
}

sub Debug ($)  { print "[ $package ] $_[0]\n"; }

1;

__END__

=head1 NAME

Geo::Query - Perl extension for querying geo related data from different sources.

=head1 SYNOPSIS

  use Geo::Query;

Library. This will be the container for future Geo::Query::Any modules.

  Geo::Query::LatLong is already available on CPAN:

  http://search.cpan.org/dist/Geo-Query-LatLong/lib/Geo/Query/LatLong.pm

=head1 DESCRIPTION

A library. Returns information about the Geo-Query modules.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Geo::Query::LatLong

http://meta.pgate.net/perl-modules/


=head1 AUTHOR

Reto Schaer, E<lt>reto@localdomainE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by reto

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
