% Author:
% Date: 2016/7/11

replace_elem(_, _, [], _) :- !, fail.
replace_elem(Old, New, [Old|Z], [New|Z]) :- !.
replace_elem(Old, New, [X|Z], [X|Z2]) :-
  replace_elem(Old, New, Z, Z2).

get_integer(L,H,X):-L>H,!,fail.
get_integer(L,H,L).
get_integer(L,H,X):-L1 is L+1,get_integer(L1,H,X).

exchange(X,Y,L,L1):-
        replace_elem(X,0,L,L2),
        replace_elem(Y,X,L2,L3),
        replace_elem(0,Y,L3,L1).

member(A,[A|X]).
member(A,[B|X]) :- member(A,X).

nth_elem(L, X, N) :-
  nth_elem(L, X, 1, N).

  nth_elem([X|Z], X, N, N).
  nth_elem([_|Z], X, A, N) :-
    AA is A + 1,
    nth_elem(Z, X, AA, N).

length(L, N) :-length(L, 0, N).

  length([], N, N).
  length([_|Y], X, N) :-
    XX is X + 1,
    length(Y, XX, N).

writep(A):-
        writep1(A,1).


writep1([],N):-!.
writep1([X|L],N):-
       0=\=N mod 3,
       write(X),
        N1 is N+1,
       writep1(L,N1).

writep1([X|L],N):-
       0=:=N mod 3,
       write(X),
        nl,
        N1 is N+1,
       writep1(L,N1).

writetab([]):-nl.
writetab([A|L]):-
        writep(A),
        nl,
        writetab(L).

init:- %加入棋盘的连接信息。
assert(link(1,2)),
assert(link(2,3)),
assert(link(4,5)),
assert(link(5,6)),
assert(link(7,8)),
assert(link(8,9)),
assert(link(1,4)),
assert(link(4,7)),
assert(link(2,5)),
assert(link(5,8)),
assert(link(3,6)),
assert(link(6,9)).

near(X,Y):-
   link(X,Y);link(Y,X).

goal([1,2,3,4,5,6,7,8,9]).

stepgoal(1,[1,Z,Y,A,B,C,D,E,F],2).
stepgoal(2,[1,2,Y,A,B,C,D,E,F],3).
stepgoal(3,[1,2,A,B,C,3,D,E,F],3):-
        cur([_,_,_,_,_,_,3,_,_]),!.
stepgoal(3,[1,2,3,A,B,C,D,E,F],4).
stepgoal(4,[1,2,3,4,B,C,D,E,F],5).
stepgoal(5,[1,2,3,4,5,C,D,E,F],6).
stepgoal(6,[1,2,3,4,5,6,D,E,F],7).
stepgoal(7,[1,2,3,4,5,6,7,8,9],8).

unsolveable([1,2,3,4,5,6,8,7,9]).
unsolveable([1,2,3,4,5,6,8,9,7]).
unsolveable([1,2,3,4,5,6,9,8,7]).

connect(L,L1):-
        nth_elem(L,9,X), % where is 9, 9 is the space in the game.
        near(X,Y),
        nth_elem(L,Z,Y), % Yth_elem is Z
        exchange(9,Z,L,L1).

stage:-
        repeat,  %定义循环
        retract(stage(N)), %读入当前的目标级别N。
        cur(X), %读入当前的方块状态。
        write(step-N),
        nl,
        write('cur'-X),
        nl,
        stepgoal(N,Y,N2),%根据N,获得目标状态。
        find(L,X,Y), %寻找从当前状态到目标状态的解L。
        writetab(L), %输出解L
        retract(cur(X)),
        asserta(cur(Y)), %把目标状态作为当前状态加入，以开始下一轮的搜索。
        assert(stage(N2)), %N2为下一级目标级别。
        N2>=8, %如果目标级别没超过8，即没有达到最终结果，则回溯。
        retract(cur(_)), %清理内存。
        retract(stage(_)).%清理内存。

main:-  %主程序
        init,  %调用初始化，加入棋盘的连接信息。
        write('Please Input your puzzle-'),
        nl,
        asserta(stage(1)), %初始化子目标。
        read(X), %键盘输入待解决的状态。
        write('Please Wait... Solving'),
        nl,
        tell('solve.txt'), %打开文件solve.txt，其后的输出全部都写入此文件。
        asserta(cur(X)),  %把待解决的状态写入内存。
        stage,!, %调用求解谓词。只需要找到一种解法，所以使用截断。
        told, %关闭文件。
        write('complete! Please read the file solve.txt to see to result.'),
        nl.

append([], X, X).
append([A|X], Y, [A|Z]) :- append(X,Y,Z).

testdel([1,2,3,4,_,_,_,_,_]):- %目标状态为此时表示1,2,3,已经归位，可以删除一些无用的连接信息。
        retract(link(1,2)),
        retract(link(2,3)),
        retract(link(1,4)),
        retract(link(2,5)),
        retract(link(3,6)).
testdel(_). %保证testdel/1谓词成功，否则会引起find/3谓词失败。

find(X,Y,Z):-
     not(unsolveable(Y)), %判断目标状态是否有解
     testdel(Y),  % 判断目标是否已经摆好了第一排。如果摆好了，就可以除去一些不必要的连接信息。
     findroad(X,Y,Z),!. %调用真正的广度搜索谓词，并且只需找到一个解就可以了，所以使用截断。

find(X,Y,Z):- %若上一个子句没有满足则说明无解。
        write('can not solve this!'),
        nl.

findroad([],X,X).
findroad(Moves,State,Crit):-
        findroad(PrMoves,State,NextState),
        not(member(NextState,PrMoves)),
        connect(NextState,Crit),
        append(PrMoves,[NextState],Moves).