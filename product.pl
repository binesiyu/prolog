% Author: binesiyu
% Date: 2016/7/15

:-op(230, xfx, ==>).
:-op(32, xfy, :).
:-op(250, fx, rule).

initial_data([read_facts]).　%初始状态，在系统运行的时候，初始状态会写入工作空间。
rule 1: %这个规则定义了读入数据循环的结束条件。
[1: end, % 即如果工作空间中同时存在end和read_facts两项时，
2: read_facts]
==>
[retract(all)]. % 就把这两项删除。

rule 2: %这个规则是循环体
[1: read_facts] % 如果工作空间中存在项read_facts，
==>
[prompt('Attribute? ', X), %提示用户输入数据，
assert(X)]. % 并把此数据写入到工作空间，注意如果用户输入end，规则1将先满足，从而删除read_facts项，使得规则2将不会再被满足。

go:-
call(rule ID: LHS ==> RHS), %获得某个规则的LHS和RHS
try(LHS, RHS), %测试并运行匹配的规则
write('Rule fired '), write(ID), nl, %输出所使用的规则
!, go. %循环


go:- %当第一个子句失败，也就是没有规则可以运用的时候，循环结束
nl, write(done), nl,
print_state. %输出工作空间的状态

try(LHS, RHS):- %考察LHS，并且运行RHS
match(LHS), %判断LHS是否与工作空间的数据匹配
process(RHS, LHS). %如果匹配，则运行RHS，注意在RHS中的某些动作需要LHS中的数据，因此把LHS也传递给谓词process/2。

match([]) :- !. %条件列表为空则结束


match([N:Prem|Rest]) :-%处理有编号的条件
!,
(fact(Prem); %此条件要么是工作空间中的事实
test(Prem)), %要么是比较数值大小
match(Rest). %递归调用处理剩下的条件列表


match([Prem|Rest]) :- %处理没有编号的条件
(fact(Prem);
test(Prem)),
match(Rest).

test(X >= Y):- X >= Y, !.
test(X = Y):- X is Y, !. % use = for arithmetic
test(X : Y):- X = Y, !. % use # for unification
test(member(X, Y)):- member(X, Y), !.


test(not(X)):-
fact(X),
!, fail.


process([], _) :- !.
process([Action|Rest], LHS) :-
take(Action, LHS), %调用take/2运行Action
process(Rest, LHS).%处理剩下的动作列表

take(retract(N), LHS) :- %如果动作是retract
(N == all; integer(N)), %其中N要么是一个整数，要么是all。
retr(N, LHS), !. %调用retr/2来完成retract动作


take(A, _) :-take(A), !. %如果是别的种类的动作，则调用take/1实现。
take(retract(X)) :- retract(fact(X)), !.
take(assert(X)) :- asserta(fact(X)), write(adding-X), nl, !.
take(X : Y) :- X=Y, !.
take(X = Y) :- X is Y, !.
take(write(X)) :- write(X), !.
take(nl) :- nl, !.
take(read(X)) :- read(X), !.

retr(all, LHS) :-retrall(LHS), !.
retr(N, []) :-write('retract error, no '-N), nl, !.
retr(N, [N:Prem|_]) :- retract(fact(Prem)), !.
retr(N, [_|Rest]) :- !, retr(N, Rest).
retrall([]).


retrall([N:Prem|Rest]) :-
retract(fact(Prem)),
!, retrall(Rest).


retrall([Prem|Rest]) :-
retract(fact(Prem)),
!, retrall(Rest).


retrall([_|Rest]) :- % must have been a test
retrall(Rest).

