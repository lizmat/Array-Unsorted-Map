[![Actions Status](https://github.com/lizmat/Array-Unsorted-Map/workflows/test/badge.svg)](https://github.com/lizmat/Array-Unsorted-Map/actions)

NAME
====

Array::Unsorted::Map - Provide a Map interface for 2 unsorted lists

SYNOPSIS
========

```raku
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
```

DESCRIPTION
===========

`Array::Unsorted::Map` is a class that can be used to provide a `Map` interface to two unsorted lists: one for keys, and one for values, where the key in the first list, is associated with the value in the second list at the same position.

By default, keys are found by doing a string comparison with the elements in the list of keys. This can be overriden by specifying a `finder` named parameter containing code that will take the list and the key as parameters. This is then expected to either return an index position or Nil.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2021 Elizabeth Mattijsen

Source can be located at: https://github.com/lizmat/Array-Unsorted-Map . Comments and Pull Requests are welcome.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

