% RUBLOAD - Loads the necessary files for solving Rubik's Cube.

:-nl,write('loading rubik'),nl,
    consult('rubik.pl').
:-write('loading rubmov'),nl,
    consult('rubmov.pl').
:-write('loading rubdata'),nl,
    consult('rubdata.pl').
:-write('loading rubdisp'),nl,
    consult('rubdisp.pl').
:-write('loading rubhist'),nl,
    consult('rubhist.pl').
:-write('loading rubedit'),nl,
    consult('rubedit.pl').
:-write('loading rubhelp'),nl,
    consult('rubhelp.pl').
:-retract((restart:-X)).
:- write('rubik loaded'),nl.
