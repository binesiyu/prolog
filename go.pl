% Author:
% Date: 2016/7/11

get_integer(L,H,X):-L>H,!,fail.
get_integer(L,H,L).
get_integer(L,H,X):-L1 is L+1,get_integer(L1,H,X).

append([], X, X).
append([A|X], Y, [A|Z]) :- append(X,Y,Z).

member(A,[A|X]).
member(A,[B|X]) :- member(A,X).

del_move:-
        retract(move(X,Y)),
        fail.
del_move.

del_stat:-
        retract(inistatu(X)),
        retract(desstatu(Y)),!.
del_stat.

insert_move(N):-
        insert_move0(N),
        insert_move1(N).

insert_move0(0).
insert_move0(N):-
        asserta(move(N,0)),
        asserta(move(0,N)),
        N1 is N-1,
        insert_move0(N1).

insert_move1(N):-
        get_integer(1,N,X),
        get_integer(X,N,Y),
        X+Y=<N,
        asserta(move(Y,X)),
        fail.
insert_move1(_).

legal((X,Y,_)):-
        legal1(X),
        legal1(Y).

legal1((X,Y)):-
        X=:=0,Y>=0,!.
legal1((X,Y)):-
        Y=:=0,X>=0,!.
legal1((X,Y)):-
        X>=Y,X>=0,Y>=0.


update((X,Y,0),Move,Statu1):-
        (A,B)=X,
        (C,D)=Y,
        (E,F)=Move,
        C1 is C+E,
        D1 is D+F,
        A1 is A-E,
        B1 is B-F,
        Statu1=((A1,B1),(C1,D1),1).
update((X,Y,1),Move,Statu1):-
        (A,B)=X,
        (C,D)=Y,
        (E,F)=Move,
        C1 is C-E,
        D1 is D-F,
        A1 is A+E,
        B1 is B+F,
        Statu1=((A1,B1),(C1,D1),0).

connect(Statu,Statu1):-
        move(X,Y),
        update(Statu,(X,Y),Statu1),
        legal(Statu1).


findroad(X,X,L,L).% 递归的边界条件。
findroad(X,Y,L,L1):-  % L为储存的路由表。
        connect(X,Z),
        not(member(Z,L)), % X所连接的节点Z不在已经储存的路由表中。
        findroad(Z,Y,[Z|L],L1).

findroad([],X,X).
findroad(Moves,State,Crit):-
        findroad(PrMoves,State,NextState),
        not(member(NextState,PrMoves)),
        connect(NextState,Crit),
        append(PrMoves,[NextState],Moves).

insert_statu(N):-
        asserta(inistatu(((N,N),(0,0),0))),
        asserta(desstatu(((0,0),(N,N),1))).

writelist([]).
writelist([X|L]):-
        write(X),
        nl,
        writelist(L).

widesolve(N,M):-
        del_move,
        del_stat,
        insert_move(M),
        insert_statu(N),
        inistatu(X),
        desstatu(Y),
        !,
        findroad(L,X,Y),
        writelist(L),
        nl.


deepsolve(N,M):-
        del_move,
        del_stat,
        insert_move(M),
        insert_statu(N),
        inistatu(X),
        desstatu(Y),
        !,
        findroad(Y,X,[Y],L),
        writelist(L),
        nl.

