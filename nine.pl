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

init:- %�������̵�������Ϣ��
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
        repeat,  %����ѭ��
        retract(stage(N)), %���뵱ǰ��Ŀ�꼶��N��
        cur(X), %���뵱ǰ�ķ���״̬��
        write(step-N),
        nl,
        write('cur'-X),
        nl,
        stepgoal(N,Y,N2),%����N,���Ŀ��״̬��
        find(L,X,Y), %Ѱ�Ҵӵ�ǰ״̬��Ŀ��״̬�Ľ�L��
        writetab(L), %�����L
        retract(cur(X)),
        asserta(cur(Y)), %��Ŀ��״̬��Ϊ��ǰ״̬���룬�Կ�ʼ��һ�ֵ�������
        assert(stage(N2)), %N2Ϊ��һ��Ŀ�꼶��
        N2>=8, %���Ŀ�꼶��û����8����û�дﵽ���ս��������ݡ�
        retract(cur(_)), %�����ڴ档
        retract(stage(_)).%�����ڴ档

main:-  %������
        init,  %���ó�ʼ�����������̵�������Ϣ��
        write('Please Input your puzzle-'),
        nl,
        asserta(stage(1)), %��ʼ����Ŀ�ꡣ
        read(X), %��������������״̬��
        write('Please Wait... Solving'),
        nl,
        tell('solve.txt'), %���ļ�solve.txt���������ȫ����д����ļ���
        asserta(cur(X)),  %�Ѵ������״̬д���ڴ档
        stage,!, %�������ν�ʡ�ֻ��Ҫ�ҵ�һ�ֽⷨ������ʹ�ýضϡ�
        told, %�ر��ļ���
        write('complete! Please read the file solve.txt to see to result.'),
        nl.

append([], X, X).
append([A|X], Y, [A|Z]) :- append(X,Y,Z).

testdel([1,2,3,4,_,_,_,_,_]):- %Ŀ��״̬Ϊ��ʱ��ʾ1,2,3,�Ѿ���λ������ɾ��һЩ���õ�������Ϣ��
        retract(link(1,2)),
        retract(link(2,3)),
        retract(link(1,4)),
        retract(link(2,5)),
        retract(link(3,6)).
testdel(_). %��֤testdel/1ν�ʳɹ������������find/3ν��ʧ�ܡ�

find(X,Y,Z):-
     not(unsolveable(Y)), %�ж�Ŀ��״̬�Ƿ��н�
     testdel(Y),  % �ж�Ŀ���Ƿ��Ѿ��ں��˵�һ�š�����ں��ˣ��Ϳ��Գ�ȥһЩ����Ҫ��������Ϣ��
     findroad(X,Y,Z),!. %���������Ĺ������ν�ʣ�����ֻ���ҵ�һ����Ϳ����ˣ�����ʹ�ýضϡ�

find(X,Y,Z):- %����һ���Ӿ�û��������˵���޽⡣
        write('can not solve this!'),
        nl.

findroad([],X,X).
findroad(Moves,State,Crit):-
        findroad(PrMoves,State,NextState),
        not(member(NextState,PrMoves)),
        connect(NextState,Crit),
        append(PrMoves,[NextState],Moves).