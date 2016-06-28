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
setElementoLista([H|T], J, X, [H|R]):- J > -1, NJ is J-1, setElementoLista(T, NJ, X, R), !.


%%%%altera um elemento de uma matriz%%
%%%esetElementoMatriz(M,I,J,E,Nm)%%
setElementoMatriz([H|T],0,I,E,[N|T]) :- setElementoLista(H,I,E,N).
setElementoMatriz([H|T],J,I,E,[H|R]) :- J > 0, J1 is J-1, setElementoMatriz(T,J1,I,E,R), !.


%%%%obtém um elemento dado uma posição de uma lista
% Encontra o elemento de uma lista a partir do índice
getElementoLista([H|_], 0, H):- !.
getElementoLista([_|T], J, E):- X is J - 1, getElementoLista(T, X, E).


%%%%obtém um elemento dado uma posição de uma matriz
getElementoMatriz([H|_],0,J,E) :- getElementoLista(H,J,E), !.
getElementoMatriz([_|T],I,J,E) :- In is I - 1, getElementoMatriz(T, In, J, E).

%%%retorna o número de linhas de uma matriz
getNumberOfLines(M,R) :- length(M,R).


%%%Troca os valores da posição ij pela kl e vice-versa
swap(M,I,J,K,L,Mr) :- getElementoMatriz(M,I,J,Ei), getElementoMatriz(M,K,L,Ek), setElementoMatriz(M,I,J,Ek,M1), setElementoMatriz(M1, K, L, Ei, Mr).
 