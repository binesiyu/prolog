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
%��������ʹ��range/3�����б���ʹ��queens/3�����ûʺ�
        range(1,N,Ns),queens(Ns,[],Qs).

queens(UnplacedQs,SafeQs,Qs):-
% UnplaceQs�ǻ�û�з��õĻʺ�SafeQs���Ѿ��ź��˵Ļʺ��б�
        delete(Q,UnplacedQs,UnplacedQs1),
% ����ʹ��delete/3��UnplaceQs�б���ѡ��һ���ʺ������
        not(attack(Q,SafeQs)),
% �ж����Ƿ����Ѿ��ź��˵Ļʺ��ܹ����๥����
        queens(UnplacedQs1,[Q|SafeQs],Qs).
% ������ܹ�������ô�ͰѴ˻ʺ�ŵ�SafeQs�б��У�
% ���ҿ�ʼѡ����һ���ʺ�

queens([],Qs,Qs).
% ������еĻʺ󶼷��ú��ˣ��Ͱѵڶ�����������������������
