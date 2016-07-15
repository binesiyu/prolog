% Author: binesiyu
% Date: 2016/7/15

:-op(230, xfx, ==>).
:-op(32, xfy, :).
:-op(250, fx, rule).

initial_data([read_facts]).��%��ʼ״̬����ϵͳ���е�ʱ�򣬳�ʼ״̬��д�빤���ռ䡣
rule 1: %����������˶�������ѭ���Ľ���������
[1: end, % ����������ռ���ͬʱ����end��read_facts����ʱ��
2: read_facts]
==>
[retract(all)]. % �Ͱ�������ɾ����

rule 2: %���������ѭ����
[1: read_facts] % ��������ռ��д�����read_facts��
==>
[prompt('Attribute? ', X), %��ʾ�û��������ݣ�
assert(X)]. % ���Ѵ�����д�뵽�����ռ䣬ע������û�����end������1�������㣬�Ӷ�ɾ��read_facts�ʹ�ù���2�������ٱ����㡣

go:-
call(rule ID: LHS ==> RHS), %���ĳ�������LHS��RHS
try(LHS, RHS), %���Բ�����ƥ��Ĺ���
write('Rule fired '), write(ID), nl, %�����ʹ�õĹ���
!, go. %ѭ��


go:- %����һ���Ӿ�ʧ�ܣ�Ҳ����û�й���������õ�ʱ��ѭ������
nl, write(done), nl,
print_state. %��������ռ��״̬

try(LHS, RHS):- %����LHS����������RHS
match(LHS), %�ж�LHS�Ƿ��빤���ռ������ƥ��
process(RHS, LHS). %���ƥ�䣬������RHS��ע����RHS�е�ĳЩ������ҪLHS�е����ݣ���˰�LHSҲ���ݸ�ν��process/2��

match([]) :- !. %�����б�Ϊ�������


match([N:Prem|Rest]) :-%�����б�ŵ�����
!,
(fact(Prem); %������Ҫô�ǹ����ռ��е���ʵ
test(Prem)), %Ҫô�ǱȽ���ֵ��С
match(Rest). %�ݹ���ô���ʣ�µ������б�


match([Prem|Rest]) :- %����û�б�ŵ�����
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
take(Action, LHS), %����take/2����Action
process(Rest, LHS).%����ʣ�µĶ����б�

take(retract(N), LHS) :- %���������retract
(N == all; integer(N)), %����NҪô��һ��������Ҫô��all��
retr(N, LHS), !. %����retr/2�����retract����


take(A, _) :-take(A), !. %����Ǳ������Ķ����������take/1ʵ�֡�
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

