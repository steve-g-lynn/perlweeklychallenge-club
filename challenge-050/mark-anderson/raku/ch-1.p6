#!/usr/bin/env perl6

use Test;

plan 3;

is-deeply merge([[2,7], [3,9], [10,12], [15,19], [18,22]]),
                [[2,9], [10,12], [15,22]];

is-deeply merge([[1,3], [5,9], [7,8], [3,4]]),
                [[1,4], [5,9]];

is-deeply merge([[1,2], [5,6], [5,5], [2,5], [7,8], [3,3]]),
                [[1,6], [7,8]];

sub merge(@array) {
    @array = @array.sort({ $^a[0] <=> $^b[0] ||
                           $^a[1] <=> $^b[1] });

    my @merged = @array.shift;

    while @array {
        my @m = @merged.pop.flat;  
        my @a = @array.shift.flat; 

        if (@m[1] >= @a[0]) {
            @merged.push([@m[0], (@a[1], @m[1]).max]);
        }

        else {
            @merged.append(@m, @a);
        }
    }

    return @merged;
}
