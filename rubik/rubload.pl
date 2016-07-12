% RUBLOAD - Loads the necessary files for solving Rubik's Cube.

:-nl,write('loading rubik'),nl,
    consult('rubik.pr').
:-write('loading rubdata'),nl,
    consult('rubdata.pr').
:-write('loading rubdisp'),nl,
    consult('rubdisp.pr').
:-write('loading rubedit'),nl,
    consult('rubedit.pr').
:-write('loading rubhelp'),nl,
    consult('rubhelp.pr').
:-write('loading rubhist'),nl,
    consult('rubhist.pr').
:-write('loading rubmov'),nl,
    consult('rubmov.pr').
:-write('rubik loaded'),nl.
