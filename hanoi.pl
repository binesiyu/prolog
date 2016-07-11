% Author:
% Date: 2016/7/11

hanoi(N):-
move(1,_,N,left,middle,right).


move(S,NS,1,A,_,C):-
inform(S,NS,1,A,C),
!.


move(S,NS,N,A,B,C):-
N1 is N-1,
move(S,NS1,N1,A,C,B),
inform(NS1,NS2,N,A,C),
move(NS2,NS,N1,B,A,C).


inform(S,NS,Num,Loc1, Loc2):-
nl,
write('[' -S- ']Move ' -Num- ' from '-Loc1-' to '-Loc2),
NS is S + 1.
