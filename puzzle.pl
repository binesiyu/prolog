% Author:
% Date: 2016/7/11

delall:-
        retract(add(_,_,_,_,_)),
        fail.
delall.

%�����ӷ���
makeback:-
        delall,%ɾ����ǰ�ļӷ���

        get_integer(0,9,X), %X��YΪ����������
        get_integer(0,9,Y),
        get_integer(0,1,Z), %ZΪ��һλ�Ľ�λ ֻ�ܹ���1����0
        A is X+Y+Z,
        B is A // 10,
        C is A mod 10,
        assert(add(X,Y,Z,B,C)),  %BΪ��һλ�Ľ�λ��CΪ��λ�ĵ�����
            fail.
makeback.
%�б�ν��
member(A,[A|X]).
member(A,[B|X]) :- member(A,X).

%�б��Ԫ�ض�����ͬʱΪ�档
diff([X]).
diff([A|B]):-
not(member(A,B)),
diff(B).
% donald+gerald=robert
% ������
main:-
        makeback, %�����ӷ���
        !,
        D is 5,             %����������д�ļӷ�˳��
        add(D,D,0,J1,T),
        add(L,L,J1,J2,R),
        add(A,A,J2,J3,E),
        add(N,R,J3,J4,B),
        add(O,E,J4,J5,O),
        add(D,G,J5,0,R),
        G =\=0,    %��λ���ܹ�Ϊ�㡣
        R =\=0,
        List = [D,O,N,A,L,G,E,R,T,B], %������ĸ���������Ӧ�ò�ͬ
        diff(List),
        write('the puzzle is donald+gerald=robert, and d is 5'),
        nl,
        write([d,o,n,a,l,g,e,r,t,b]),
        nl,
        write(List),
        nl,
        write([D,O,N,A,L,D]),  %���
        nl,
        write([G,E,R,A,L,D]),
        nl,
        write([R,O,B,E,R,T]),
        nl,
        nl,
        fail. %Ѱ����һ����