% Author:
% Date: 2016/7/11

like(one,two).
like(two,three).

fun1(A,B):-write("fun1 normal"),like(A,B).
fun1(_,_):-write("fun1 end").

fun2(A,B):-like(A,B),write("fun1 normal"),nl.
fun2(_,_):-write("fun1 end").