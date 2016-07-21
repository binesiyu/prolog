% Author:
% Date: 2016-7-14

bird(laysan_albatross) :-
family(albatross),
color(white).

bird(laysan_albatross):-
family(albatross),
color(white).

bird(black_footed_albatross):-
family(albatross),
color(dark).

bird(whistling_swan) :-
family(swan),
voice(muffled_musical_whistle).

bird(trumpeter_swan) :-
family(swan),
voice(loud_trumpeting).

order(tubenose) :-
nostrils(external_tubular),
live(at_sea),
bill(hooked).

order(waterfowl) :-
feet(webbed),
bill(flat).

family(albatross) :-
order(tubenose),
size(large),
wings(long_narrow).

family(swan) :-
order(waterfowl),
neck(long),
color(white),
flight(ponderous).

/*
nostrils(external_tubular).
live(at_sea).
bill(hooked).
size(large).
wings(long_narrow).
color(dark).
 */
 
bird(canada_goose):-
family(goose),
season(winter),
country(united_states),
head(black),
cheek(white).

bird(canada_goose):-
family(goose),
season(summer),
country(canada),
head(black),
cheek(white).

country(united_states):-
region(mid_west).

country(united_states):-
region(south_west).

country(united_states):-
region(north_west).

country(united_states):-
region(mid_atlantic).

country(canada):- province(ontario).

country(canada):- province(quebec).

region(new_england):-
state(X), member(X, [massachusetts, vermont, ....]).

region(south_east):- state(X), member(X, [florida, mississippi]).

bird(mallard):- family(duck), voice(quack), head(green). bird(mallard):- family(duck), voice(quack), color(mottled_brown).

nostrils(X):-ask(nostrils,X).
eats(X):- ask(eats, X).
feet(X):- ask(feet, X).
wings(X):- ask(wings, X).
neck(X):- ask(neck, X).
color(X):- ask(color, X).
live(X):- ask(live, X).
bill(X):- ask(bill, X).
%size(X):- ask(size, X).

menuask(A, V, MenuList) :-
write('What is the value for'), write(A), write('?'), nl,
write(MenuList), nl,
read(X),
check_val(X, A, V, MenuList),
asserta( known(yes, A, X) ),
X == V.

check_val(X, A, V, MenuList) :- %����û������ֵ���б��п����ҵ���
member(X, MenuList), !.

check_val(X, A, V, MenuList) :- %����Ҳ�����
write(X), write(' is not a legal value, try again.'), nl,
menuask(A, V, MenuList).


size(X):- menuask(size, X, [large, plump, medium, small]).
flight(X):- menuask(flight, X, [ponderous, agile, flap_glide]).



multivalued(voice).
multivalued(feed).


known(_,_,_).

ask(A, V):-
not(multivalued(A)),
known(yes, A, V), % �����������Ѿ��д�yes����ôaskĿ��ͳɹ���
!. % ����Ҫ����������ask�Ӿ䡣

ask(A, V):-
known(_, A, V), % �������no��askĿ���ʧ�ܡ�
!, fail.

ask(A, V):-
write(A:V), % ѯ���û�
write('? : '),
read(Y), % �õ���
asserta(known(Y, A, V)), % �Ѵ𰸼�¼������
Y == yes. % �ж��û��Ļش�






