[coordenada].
[direcao].
[piece].
[utils].
[tabuleiro].

%define mudança de turno
modificarTurno(Turno, R) :- Turno == 1, R is 2.
modificarTurno(Turno, R) :- Turno == 2, R is 1.


%jogar
jogar(Tabuleiro, Turno, Nt) :- write("Digite a linha: "), read(X),
	write("Digite a coluna: "), read(Y),
	write("Digite a direção: "), read(O),
	getCoordenada(X,Y,getCoordenada), parseDirecao(O,D),
	move(Coordenada, D, Tabuleiro, Turno, Nt).


%%define o motor do jogo. laço principal
motor(Tabuleiro, Turno, Nt) :- haveWinner(Tabuleiro), write("Ganhou!").
motor(Tabuleiro, Turno, Nt) :- printTabuleiro(Tabuleiro, Turno, R), write(R),
	jogar(Tabuleiro, Turno, Tr), modificarTurno(Turno, Nturno), motor(Tr, Nturno, Nt), !.
