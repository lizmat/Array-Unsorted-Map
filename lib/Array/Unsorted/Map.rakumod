my sub finder(\keys, \key) { keys.first(* eq key, :k) }

class Array::Unsorted::Map:ver<0.0.1>:auth<zef:lizmat> does Associative {
    has $.keys   is built(:bind) is required;
    has $.values is built(:bind) is required;
    has &.finder is built(:bind) = &finder;

    method AT-KEY(\key) {
        (my $pos := &!finder($!keys, key)).defined
          ?? $!values[$pos]
          !! Nil
    }

    method EXISTS-KEY(\key) { &!finder($!keys, key).defined }

    method kv() {
        gather for ^$!keys.elems {
            take $!keys[$_];
            take $!values[$_];
        }
    }
    method anti-pairs() {
        (^$!keys.elems).map: -> int $i { $!values[$i] => $!keys[$i] }
    }
    method pairs() {
        (^$!keys.elems).map: -> int $i { $!keys[$i] => $!values[$i] }
    }
    method iterator() {
        self.pairs.iterator
    }
}

=begin pod

=head1 NAME

Array::Unsorted::Map - Provide a Map interface for 2 unsorted lists

=head1 SYNOPSIS

=begin code :lang<raku>

use Array::Unsorted::Util;
use Array::Unsorted::Map;

my @keys   = <b a>;
my @values = 666, 42;

my %map := Array::Unsorted::Map.new(:@keys, :@values);

say %map<a>;  # 42;
say %map<b>;  # 666;
say %map<c>;  # Nil

say %map.keys;    # (b a)
say %map.values;  # (666 42)

my @object-keys = @keys.map: *.WHICH;
my %object-map := Array::Unsorted::Map.new(
  :keys(@object-keys), :@values), :finder( -> \keys, \key {
      my $which := key.WHICH;
      keys.first(* eq $which, :k)
  })
);

=end code

=head1 DESCRIPTION

C<Array::Unsorted::Map> is a class that can be used to provide a C<Map>
interface to two unsorted lists: one for keys, and one for values, where the
key in the first list, is associated with the value in the second list at the
same position.

By default, keys are found by doing a string comparison with the elements in
the list of keys.  This can be overriden by specifying a C<finder> named
parameter containing code that will take the list and the key as parameters.
This is then expected to either return an index position or Nil.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

=head1 COPYRIGHT AND LICENSE

Copyright 2021 Elizabeth Mattijsen

Source can be located at: https://github.com/lizmat/Array-Unsorted-Map .
Comments and Pull Requests are welcome.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
