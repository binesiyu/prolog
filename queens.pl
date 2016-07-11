% Author:
% Date: 2016/7/11

queens1(N,Qs):-
        range(1,N,Ns),permutation(Qs,Ns),safe(Qs).

range(M,N,[M|Ns]):-
        M<N,M1 is M+1,range(M1,N,Ns).
range(N,N,[N]).

safe([Q|Qs]):-
        safe(Qs),not(attack(Q,Qs)).
safe([]).

attack(X,Xs):-
        attack(X,1,Xs).

attack(X,N,[Y|Ys]):-
        X is Y+N;X is Y-N.

attack(X,N,[Y|Ys]):-
        N1 is N+1,attack(X,N1,Ys).

permutation([],[]).
permutation([A|X],Y) :- delete(A,Y,Y1), permutation(X,Y1).

delete(A,[A|X],X).
delete(A,[B|X],[B|Y]) :- delete(A,X,Y).

queens(N,Qs):-
%主程序，先使用range/3生成列表，再使用queens/3来放置皇后。
        range(1,N,Ns),queens(Ns,[],Qs).

queens(UnplacedQs,SafeQs,Qs):-
% UnplaceQs是还没有放置的皇后，SafeQs是已经放好了的皇后列表。
        delete(Q,UnplacedQs,UnplacedQs1),
% 首先使用delete/3从UnplaceQs列表中选择一个皇后出来。
        not(attack(Q,SafeQs)),
% 判断它是否与已经放好了的皇后能够互相攻击，
        queens(UnplacedQs1,[Q|SafeQs],Qs).
% 如果不能攻击，那么就把此皇后放到SafeQs列表中，
% 并且开始选择下一个皇后。

queens([],Qs,Qs).
% 最后当所有的皇后都放置好了，就把第二个参数传给第三个参数。
