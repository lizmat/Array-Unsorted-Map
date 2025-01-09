my sub finder(\keys, \key) { keys.first(* eq key, :k) }

class Array::Unsorted::Map:ver<0.0.4>:auth<zef:lizmat> does Associative {
    has $.keys   is built(:bind) is required handles <elems Numeric Int Bool>;
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

# vim: expandtab shiftwidth=4
