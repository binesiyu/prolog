% Author:
% Date: 2016/7/11

color(h(C,N,P,Y,D),C).
nation(h(C,N,P,Y,D),N).
pet(h(C,N,P,Y,D),P).
yan(h(C,N,P,Y,D),Y).
drink(h(C,N,P,Y,D),D).


next(A,B,[A,B,C,D,E]).
next(B,C,[A,B,C,D,E]).
next(C,D,[A,B,C,D,E]).
next(D,E,[A,B,C,D,E]).
next(B,A,[A,B,C,D,E]).
next(C,B,[A,B,C,D,E]).
next(D,C,[A,B,C,D,E]).
next(E,D,[A,B,C,D,E]).

middle(X,[_,_,X,_,_]).

first(A,[A|X]).

member(X,[X|Y]).
member(X,[Y|Z]) :- member(X,Z).

solve(X,TT,TTT):-
  %���Ȱ�X��Ϊ�����б�ע���ʱ�ķ�������Ի�����ȷ�������Զ�ʹ�ñ�������
  X=[h(C1,N1,P1,Y1,D1),h(C2,N2,P2,Y2,D2),h(C3,N3,P3,Y3,D3),h(C4,N4,P4,Y4,D4),h(C5,N5,P5,Y5,D5)],


  %Ӣ���ˣ�englishman��ס�ں�ɫ��red���ķ����
  member(Z1,X),  %���ȴ�X�б���ѡ��һ������Z1��
  color(Z1,red),  %Z1����ɫ��red��
  nation(Z1,englishman), %Z1��ס������englishman�� ��ͬ��


 %�������ˣ�spaniard������һ������dog����
  member(Z2,X),
  pet(Z2,dog),
  nation(Z2,spaniard),


  %Ų���ˣ�norwegian��ס����ߵĵ�һ�������
  first(Z3,X),
  nation(Z3,norwegian),


  %�Ʒ��ӣ�yellow�������ϲ����kools�Ƶ����̡�
  member(Z4,X),
  yan(Z4,kools),
  color(Z4,yellow),

  %��chesterfields�����̵����������꣨fox���������ھӡ�
  member(Z5,X),
  pet(Z5,fox),
  next(Z6,Z5,X),   %��next(Z5,Z6,X)Ҳһ����
  yan(Z6,chesterfields),


  %Ų���ˣ�norwegian��ס����ɫ��blue���ķ����Աߡ�
  member(Z7,X),
  color(Z7,blue),
  next(Z8,Z7,X),
  nation(Z8,norwegian),


  %��winston�����̵�������һֻ��ţ��Snails����
  member(Z9,X),
  yan(Z9,winston),
  pet(Z9,snails),


  %��Lucky Strike�����̵���ϲ���Ƚ���֭��orange juice����
  member(Z10,X),
  drink(Z10,'orange juice'),
  yan(Z10,'Lucky Strike'),


  %�ڿ����ˣ�ukrainian��ϲ���Ȳ裨tea����
  member(Z11,X),
  nation(Z11,ukrainian),
  drink(Z11,tea),


  %�ձ��ˣ�japanese����parliaments�Ƶ��̡�
  member(Z12,X),
  nation(Z12,japanese),
  yan(Z12,parliaments),

  %��kools�Ƶ����̵���������horse���������ھӡ�
  member(Z13,X),
  pet(Z13,horse),
  next(Z14,Z13,X),
  yan(Z14,kools),


  %ϲ���ȿ��ȣ�coffee������ס���̣�green�������
  member(Z15,X),
  color(Z15,green),
  drink(Z15,coffee),


  %�̣�green�������������ף�ivory�����ӵ��ұߣ�ͼ�е��ұߣ���
  member(Z16,X),
  color(Z16,ivory),
  next(Z17,Z16,X),  %��������û��ʹ���ұߵ����������Ǽ����������ھӣ��������Ĵ���������
  color(Z17,green),  %��һ��������Լ��޸ģ���Ȼ����Ҫ��дһ���ж��ұߵ�ν�ʡ�


  %�м��Ǹ����������ϲ����ţ�̣�milk����
  middle(Z18,X),
  drink(Z18,milk),


  %���������е����������濪ʼ�ش����ǵ����⡣


  %�ҳ�����Ϊzebra�ķ��䡣
  member(TT,X),
  pet(TT,zebra),

  %�ҳ���ˮ�ķ��䡣
  member(TTT,X),
  drink(TTT,water).

