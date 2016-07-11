% Author:
% Date: 2016/7/11

%append(L1,L2,L3).  ���б�L3��L1��L2���Ӷ���ʱ��append/3ν�ʳɹ���
append([], X, X).
append([A|X], Y, [A|Z]) :- append(X,Y,Z).

sub(a,b).
sub(a,c).
sub(a,d).
sub(b,e).
sub(c,f).
sub(c,g).
sub(d,i).
sub(d,h).

route([],X,X).
route(Links,Current,Des):-
        route(PreLinks,Current,Next),
        sub(Next,Des),
        append(PreLinks,[Next],Links).
