%%%obtém a quantidade de vezes que um elemento aparece em uma lista
getQuantidadeElementosLista(E,[],0).
getQuantidadeElementosLista(E,[Head|Tail],R) :- E==Head, getQuantidadeElementosLista(E,Tail,R1), R is R1+1.
getQuantidadeElementosLista(E,[Head|Tail],R) :- E=\=Head, getQuantidadeElementosLista(E,Tail,R).

%%obtém a quantidade de vezes que um elemento aparece em uma matriz
getQuantidadeElementosMatriz(E,[],0).
getQuantidadeElementosMatriz(E,[Head|Tail],R) :- getQuantidadeElementosMatriz(E,Tail,Rx), getQuantidadeElementosLista(E,Head,R1), R is Rx + R1. 

% Insere um elemento no início de uma lista
insereInicio(E, L, [E|L]):- !.


%%%%altera um elemento da lista
%%%%setElementoLista(Lista,Index,Elemento,NovaLista)	
setElementoLista([_|T], 0, X, [X|T]).
setElementoLista([H|T], I, X, [H|R]):- I > -1, NI is I-1, setElementoLista(T, NI, X, R), !.

%%%%altera um elemento de uma matriz%%
%%%esetElementoMatriz(M,I,J,E,Nm)%%
setElementoMatriz([H|T],I,0,E,[N|T]) :- setElementoLista(H,I,E,N).
setElementoMatriz([H|T],I,J,E,[H|R]) :- J > 0, J1 is J-1, setElementoMatriz(T,I,J1,E,R), !.

