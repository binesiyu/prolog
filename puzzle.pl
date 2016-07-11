% Author:
% Date: 2016/7/11

delall:-
        retract(add(_,_,_,_,_)),
        fail.
delall.

%产生加法表
makeback:-
        delall,%删除以前的加法表

        get_integer(0,9,X), %X，Y为两个被加数
        get_integer(0,9,Y),
        get_integer(0,1,Z), %Z为上一位的进位 只能够是1或者0
        A is X+Y+Z,
        B is A // 10,
        C is A mod 10,
        assert(add(X,Y,Z,B,C)),  %B为这一位的进位，C为本位的得数。
            fail.
makeback.
%列表谓词
member(A,[A|X]).
member(A,[B|X]) :- member(A,X).

%列表的元素都不相同时为真。
diff([X]).
diff([A|B]):-
not(member(A,B)),
diff(B).
% donald+gerald=robert
% 主调用
main:-
        makeback, %产生加法表
        !,
        D is 5,             %根据条件编写的加法顺序
        add(D,D,0,J1,T),
        add(L,L,J1,J2,R),
        add(A,A,J2,J3,E),
        add(N,R,J3,J4,B),
        add(O,E,J4,J5,O),
        add(D,G,J5,0,R),
        G =\=0,    %首位不能够为零。
        R =\=0,
        List = [D,O,N,A,L,G,E,R,T,B], %所有字母代表的数字应该不同
        diff(List),
        write('the puzzle is donald+gerald=robert, and d is 5'),
        nl,
        write([d,o,n,a,l,g,e,r,t,b]),
        nl,
        write(List),
        nl,
        write([D,O,N,A,L,D]),  %输出
        nl,
        write([G,E,R,A,L,D]),
        nl,
        write([R,O,B,E,R,T]),
        nl,
        nl,
        fail. %寻找下一个解