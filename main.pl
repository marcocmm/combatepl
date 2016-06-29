%define mudança de turno
modificarTurno(Turno, R) :- Turno == 1, R is 2.
modificarTurno(Turno, R) :- Turno == 2, R is 1.

%motor
motor(Tabuleiro, Turno).

%jogar
jogar(Tabuleiro, Turno, X) :- read(X), !.