max_bandeira(X) :- X is 1.
max_bomba(X) :- X is 7.
max_espiao(X) :- X is 1.
max_soldado(X) :- X is 8.
max_cabo(X) :- X is 5.
max_sargento(X) :- X is 4.
max_tenente(X) :- X is 4.
max_capitao(X) :- X is 3.
max_major(X) :- X is 3.
max_coronel(X) :- X is 2.
max_general(X) :- X is 1.
max_marechal(X) :- X is 1.


%obtém o tamanho do tabuleiro
%como o tabuleiro é uma matriz quadrada,
%podemos contar apenas o número de linhas
size(M, R) :- getNumberOfLines(M, R).

%retorna boolean se a coordenada está entre o tamanho do tabuleiro
isCoordenadaValida([X | Y], Tabuleiro) :- X >= 0, size(Tabuleiro, S), X < S, Y >= 0, Y < S.


%get max dado elemento
getNumeroMaxElemento(Elemento, Numero) :- bandeira(X), X==Elemento, max_bandeira(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- bomba(X), X==Elemento, max_bomba(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- espiao(X), X==Elemento, max_espiao(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- soldado(X), X==Elemento, max_soldado(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- cabo(X), X==Elemento, max_cabo(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- sargento(X), X==Elemento, max_sargento(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- tenente(X), X==Elemento, max_tenente(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- capitao(X), X==Elemento, max_capitao(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- major(X), X==Elemento, max_major(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- coronel(X), X==Elemento, max_coronel(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- general(X), X==Elemento, max_general(Numero), !.
getNumeroMaxElemento(Elemento, Numero) :- marechal(X), X==Elemento, max_marechal(Numero), !.

printLine([], Turno, _, _) :- nl.
printLine([H|T], Turno, R, C) :- territorio(Ter), normalizePiece(H,P),
  (isMyPiece(H,Turno) -> toString(P, X), write(X); (Ter == P -> write("   ");write("XXX"))),
  write(" "),
  Counter is C + 1,
  printLine(T, Turno, R, Counter).

printAllLines([], Turno, _).
printAllLines([H|T], Turno, R) :-
  printLine(H, Turno, R, 0),
  Counter is R + 1,
  printAllLines(T, Turno, Counter).

printTabuleiro(M, Turno) :- printAllLines(M, Turno, 0).

%define função que move uma peça do tabuleiro.
%retorna o novo tabuleiro
move(Coordenada, Direcao, Tabuleiro, Turno, Resultado) :- canMove(Coordenada, Direcao, Tabuleiro, Turno),
												getMoveCoordenada(Coordenada, Direcao, AttackCoordinate),
												atacar(Coordenada, AttackCoordinate, Tabuleiro, Resultado).

%calcula a jogada do computador
heuristica(Turno, Tabuleiro, Resultado) :- getPossibleMovements(Turno, Tabuleiro, PossibleMovements),
										getMelhorPeca(Tabuleiro, PossibleMovements, [0, 0], 0).

%%%retorna boolean se há vencedor
haveWinner(Tabuleiro) :- bandeira(B), getEnemyPiece(B,Bi), getQuantidadeElementos(Tabuleiro,B,Nb), getQuantidadeElementosMatriz(Bi,Tabuleiro,Nbi),T is Nb + Nbi, not(T == 2).


%%retorna boolean se é possível mover a peça para o direção dada
canMove(Coordenada, Direcao, Tabuleiro, Turno) :- isCoordenadaValida(Coordenada, Tabuleiro),
				isDirecaoValida(Direcao),
				getPiece(Coordenada, Tabuleiro, P), bandeira(Ba), bomba(Bo), territorio(T),
				not(isPieceEquals(P,Ba)), not(isPieceEquals(P,Bo)), not(isPieceEquals(P,T)),
				isMyPiece(P,Turno),
				getMoveCoordenada(Coordenada, Direcao, Nc), isCoordenadaValida(Nc,Tabuleiro).
					
%%%%obtém a peça de uma coordenada
getPiece([H,T], Tabuleiro, E) :- getElementoMatriz(Tabuleiro, H, T, E).

%verifica se é possível mover uma coordenada em alguma direção
isPossibleMove(Coordenada, Tabuleiro, Turno) :- north(Direcao), canMove(Coordenada, Direcao, Tabuleiro, Turno).
isPossibleMove(Coordenada, Tabuleiro, Turno) :- south(Direcao), canMove(Coordenada, Direcao, Tabuleiro, Turno).
isPossibleMove(Coordenada, Tabuleiro, Turno) :- west(Direcao), canMove(Coordenada, Direcao, Tabuleiro, Turno).
isPossibleMove(Coordenada, Tabuleiro, Turno) :- east(Direcao), canMove(Coordenada, Direcao, Tabuleiro, Turno).

%obtém a lista dos possíveis movimentos
getPossibleMovements(Turno, Tabuleiro) :- size(Tabuleiro, X),
										Y is X - 1,
									getPossibleMovementsOnLines(Tabuleiro, Turno, Y, Y).


%%%faz o ataque
atacar(CoordenadaA, CoordenadaD, Tabuleiro, Ntabuleiro) :- 
		getPiece(CoordenadaA, Tabuleiro, Pa), getPiece(CoordenadaD, Tabuleiro, Pd), wonInvestida(Pa,Pd),
		bomba(B), isPieceEquals(B,Pa), territorio(T), setPiece(T, CoordenadaA, Tabuleiro, Tabuleiro1), 
		setPiece(T, CoordenadaD, Tabuleiro1, Ntabuleiro), !.
atacar(CoordenadaA, CoordenadaD, Tabuleiro, Ntabuleiro) :- 
		getPiece(CoordenadaA, Tabuleiro, Pa), getPiece(CoordenadaD, Tabuleiro, Pd), wonInvestida(Pa,Pd),
		territorio(T), setPiece(T, CoordenadaA, Tabuleiro, Tabuleiro1), 
		setPiece(Pa, CoordenadaD, Tabuleiro1, Ntabuleiro), !.
atacar(CoordenadaA, CoordenadaD, Tabuleiro, Ntabuleiro) :- 
		getPiece(CoordenadaA, Tabuleiro, Pa), getPiece(CoordenadaD, Tabuleiro, Pd), not(wonInvestida(Pa,Pd)),
		territorio(T), setPiece(T, CoordenadaA, Tabuleiro, Ntabuleiro), !.


%%%altera a peça de uma coordenada
setPiece(P, [X,Y|_], Tabuleiro,Rtabuleiro) :- setElementoMatriz(Tabuleiro, X, Y, P, Rtabuleiro).



%%%%obtém o número de vezes que o elemento aparece no tabuleiro
getQuantidadeElementos(Tabuleiro, E, Q) :- getQuantidadeElementosMatriz(E, Tabuleiro, Q).













%%%verifica se é possível mover uma coordenada para sul
isPossibleMoveSouth(Coordenada, Tabuleiro, Turno) :-
		(south(S), canMove(Coordenada, S, Tabuleiro, Turno));
		(west(W), canMove(Coordenada, W, Tabuleiro, Turno), 
		getMoveCoordenada(Coordenada, W, Cw),
		getPiece(Cw, Tabuleiro, Pw), Pw > 0,
		getPiece(Cw, Tabuleiro, Pw), Pw =< 10);
		(east(E), canMove(Coordenada, E, Tabuleiro, Turno), 
		getMoveCoordenada(Coordenada, E, Ce),
		getPiece(Ce, Tabuleiro, Pe), Pe > 0,
		getPiece(Ce, Tabuleiro, Pe), Pe =< 10).

%%%calcula possíveis movimentos no tabuleiro
getPossibleMovementsOnLines(Tabuleiro, Turno, X, Y, []) :-
	Y == -1, !.
getPossibleMovementsOnLines(Tabuleiro, Turno, X, Y, R) :-
	X == -1, Y1 is Y -1, size(Tabuleiro, S), X1 is S - 1, 
	getPossibleMovementsOnLines(Tabuleiro, Turno, X1, Y1, R), !.
getPossibleMovementsOnLines(Tabuleiro, Turno, X, Y, R) :-
	getCoordenada(X,Y,Coordenada), isPossibleMoveSouth(Coordenada, Tabuleiro, Turno),
	X1 is X-1, getPossibleMovementsOnLines(Tabuleiro, Turno, X1, Y, Rn), R is [Coordenada|Rn], !.
getPossibleMovementsOnLines(Tabuleiro, Turno, X, Y, R) :-
	X1 is X - 1, getPossibleMovementsOnLines(Tabuleiro, Turno, X1, Y, R), !.


concatenar([], L, L).
concatenar([H|T], L, [H|D]) :- concatenar(T, L, D).

matrizZero(L) :- concatenar([],[[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]],L).



%%%insere aleatoriamente o exercito no tabuleiro
popularTabuleiro(Tabuleiro, I, J, Tabuleiro) :- I == -1, !.
popularTabuleiro(Tabuleiro, I, J, Nt) :- I == 5, popularTabuleiro(Tabuleiro, 3, 9, Nt), !.
popularTabuleiro(Tabuleiro, I, J, Nt) :- J == -1, I1 is I - 1, popularTabuleiro(Tabuleiro, I1, 9, Nt), !.
popularTabuleiro(Tabuleiro, I, J, Nt) :- I >= 0, I =< 3, random_between(0,12,R), getEnemyPiece(R,Ri), getNumeroMaxElemento(R,Qrt), getQuantidadeElementos(Tabuleiro, Ri, Qrd),
		Qrd < Qrt, getCoordenada(I,J,Coordenada), setPiece(Ri, Coordenada, Tabuleiro, Nti),
		J1 is J - 1, popularTabuleiro(Nti, I, J1, Nt), !.
popularTabuleiro(Tabuleiro, I, J, Nt) :- I >= 6, I =< 9, random_between(0,12,R), getNumeroMaxElemento(R,Qrt), getQuantidadeElementos(Tabuleiro, R, Qrd),
		Qrd < Qrt, getCoordenada(I,J,Coordenada), setPiece(R, Coordenada, Tabuleiro, Nti),
		J1 is J - 1, popularTabuleiro(Nti, I, J1, Nt), !.
popularTabuleiro(Tabuleiro, I, J, Nt) :- popularTabuleiro(Tabuleiro, I, J, Nt), !.