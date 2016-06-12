package Log4Perl::ImportHandle; # Imports a Log4Perl handle with category

use strict;
use Log::Log4perl;

# This class imports an easy to use Log4Perl handle to the current class. Instead of
# the not recommended way to use direct functions like DEBUG(), here you can define
# a category.
#
# SYNOPSIS
# ========
#
#  # Imports function LOG() to access category 'area1'
#  use Log4Perl::ImportHandle LOG => 'area1'
#
#  # Imports also function LOG2() to access category 'area2'
#  Log4Perl::ImportHandle LOG => 'area1',LOG2 => 'area2
#
#  # Imports function logger() to access category '' (default)
#  use Log4Perl::ImportHandle logger
#
#  # Imports function LOG() to access category '' (default)
#  # LOG is the default function name.
#  use Log4Perl::ImportHandle
#
#  LOG->debug('hello');
#
# WHY
# ===
# Please have a look at the normal way to handle with Log4Perl:
# 
#  my $log = Log::Log4perl->get_logger('area1');
#  $log->debug('hello');
#
# For classes with some methods, that is not very nice to read and maintain. You will
# also need that lines in every method again.
#
# With Log4Perl::ImportHandle it gets a bit smoother:
#
#  use Log4Perl::ImportHandle
#
#  LOG->debug('hello');
#
# Once you called it in the header via 'use', you can easily access it with the default function 'LOG'
# or any other you defined.
#
# HOWTO
# =====
# As the SYNOPSIS examples above, just 'use' the class and add maybe some parameters.
#
# What is called a handler here, is just a function, that returns the same as get_logger() from Log4Perl.
# 
# no parameters - Sets the default handle 'LOG'.
#
# one parameter - Sets the handle (function) name.
#
# two parameters or pairs - first is the handlename and the second the category name. You can define many pairs.
#
#
# LICENSE
# =======   
# You can redistribute it and/or modify it under the conditions of LGPL.
# 
# AUTHOR
# ======
# Andreas Hernitscheck  ahernit(AT)cpan.org








# Don't use that method! It is not a method but used by perl when
# this class is included to export a function in current namespace.
sub import {
	my $pkg = shift;

  my @param = @_;

  my %pair;

  
  if (scalar(@param) == 0){ ## no parameters

    $pair{'LOG'} = '';

  }elsif (scalar(@param) == 1){ ## one parameter

    $pair{ $param[0] } = '';

  }else{ ## any parameter
    %pair = @param;
  }


	my $caller = caller;
	
	require Exporter::AutoClean;

  foreach my $exportfunc (keys %pair){

    my $cat = $pair{$exportfunc};

    my %exports = (
      "$exportfunc" => sub { return Log::Log4perl->get_logger( $cat ); },
    );

    # installs the function $exportfunc in the calling class
    Exporter::AutoClean->export( $caller, %exports );

  }



}



1;

#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

Log4Perl::ImportHandle - Imports a Log4Perl handle with category


=head1 SYNOPSIS


 # Imports function LOG() to access category 'area1'
 use Log4Perl::ImportHandle LOG => 'area1'

 # Imports also function LOG2() to access category 'area2'
 Log4Perl::ImportHandle LOG => 'area1',LOG2 => 'area2

 # Imports function logger() to access category '' (default)
 use Log4Perl::ImportHandle logger

 # Imports function LOG() to access category '' (default)
 # LOG is the default function name.
 use Log4Perl::ImportHandle

 LOG->debug('hello');



=head1 DESCRIPTION

This class imports an easy to use Log4Perl handle to the current class. Instead of
the not recommended way to use direct functions like DEBUG(), here you can define
a category.



=head1 REQUIRES

L<Log::Log4perl> 


=head1 HOWTO

As the SYNOPSIS examples above, just 'use' the class and add maybe some parameters.

What is called a handler here, is just a function, that returns the same as get_logger() from Log4Perl.

no parameters - Sets the default handle 'LOG'.

one parameter - Sets the handle (function) name.

two parameters or pairs - first is the handlename and the second the category name. You can define many pairs.



=head1 WHY

Please have a look at the normal way to handle with Log4Perl:

 my $log = Log::Log4perl->get_logger('area1');
 $log->debug('hello');

For classes with some methods, that is not very nice to read and maintain. You will
also need that lines in every method again.

With Log4Perl::ImportHandle it gets a bit smoother:

 use Log4Perl::ImportHandle

 LOG->debug('hello');

Once you called it in the header via 'use', you can easily access it with the default function 'LOG'
or any other you defined.



=head1 AUTHOR

Andreas Hernitscheck  ahernit(AT)cpan.org


=head1 LICENSE

You can redistribute it and/or modify it under the conditions of LGPL.



=cut

