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
isCoordenadaValida([X, Y], [H | T]) :- X > 0, size([H | T], S), X < S.