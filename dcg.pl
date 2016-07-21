% Author: binesiyu
% Date: 2016/7/20

command([V,O]) -->
  verb(Object_Type, V),
  object(Object_Type, O).

verb(place, goto) --> [go, to].
verb(thing, take) --> [take].

object(Type, N) --> det, noun(Type, N).
object(Type, N) --> noun(Type, N).

det --> [the].
det --> [a].

noun(place,X) --> [X], {room(X)}.
noun(place,'dining room') --> [dining, room].
noun(thing,X) --> [X], {location(X,_)}.

as --> [].
as --> [a], as.

tree_nodes(nil) --> [].
tree_nodes(node(Name, Left, Right)) -->
     tree_nodes(Left),
     [Name],
     tree_nodes(Right).

tree_nodes2(nil, Ls, Ls) --> [].
tree_nodes2(node(Name, Left, Right), [_|Ls0], Ls) -->
     tree_nodes2(Left, Ls0, Ls1),
     [Name],
     tree_nodes2(Right, Ls1, Ls).
              
 nt1, [b] --> [a].