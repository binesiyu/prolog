% Author: binesiyu
% Date: 2016/7/14

q(a,'问题a1').
q(a,'问题a2').


q(b,'问题b1').
q(b,'问题b2').


q(c,'问题c1').
q(c,'问题c2').

i(a,b).
i(b,c).

ask(Attr, Val):- write(Attr), write('? '),read(Val).

qe(A,B):-q(A,B).
qe(A,B):-i(A,C),qe(C,B).

qall(A):-
         qe(A,B),not(known(A, B, V)), 
         ask(B,V),
         asserta(known(A, B, V)), % 把答案记录下来。
         fail.
         
qall(_):-known(Y,A,V),
         write(Y),tab(1),write(A),tab(1),write(V),nl,fail.

qall(_):-true.


qinit(A):-
         retractall(known(_,_,_)),
         qall(A).
