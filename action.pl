% Author: binesiyu
% Date: 2016/7/13

action:-
       sub(_),
       write('action'),
       nl,
       fail.
action:-true.

w(X):-write(X),nl.


sub(1):-w(1).
sub(2):-w(2).
sub(3):-w(3).
sub(4):-w(4).
sub(5):-w(5).
