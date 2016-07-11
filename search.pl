% Author:
% Date: 2016/7/11

%append(L1,L2,L3).  当列表L3是L1与L2连接而成时，append/3谓词成功。
append([], X, X).
append([A|X], Y, [A|Z]) :- append(X,Y,Z).

sub(a,b).
sub(a,c).
sub(a,d).
sub(b,e).
sub(c,f).
sub(c,g).
sub(d,i).
sub(d,h).

route([],X,X).
route(Links,Current,Des):-
        route(PreLinks,Current,Next),
        sub(Next,Des),
        append(PreLinks,[Next],Links).
        
route_depth([],Current,Current).
route_depth(Links,Current,Des):-
        sub(Current,Next), %首先找到current的一个子节点next,
        route_depth(PreLinks,Next,Des), %在寻找从next到目的节点Des的路由Prelinks,
        Links = [Next|PreLinks].  %最终的路由表为next加上prelinks.
