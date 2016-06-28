
%%define as coordenadas%%
getCoordenada(X,Y,[]) :- X == -2.
getCoordenada(X,Y,[X,Y|Rest]) :- getCoordenada(-2,-2,Rest).  


%%obtém coordenada para onde a peça irá%%
getMoveCoordenada([X,Y|_],Direcao,NovaCoordenada) :- Direcao == -1.
getMoveCoordenada([X,Y|_],Direcao,NovaCoordenada) :- Direcao==0, X2 is X-1,getCoordenada(X2,Y,NovaCoordenada).
getMoveCoordenada([X,Y|_],Direcao,NovaCoordenada) :- Direcao==1, X2 is X+1,getCoordenada(X2,Y,NovaCoordenada).
getMoveCoordenada([X,Y|_],Direcao,NovaCoordenada) :- Direcao==2, Y2 is Y-1,getCoordenada(X,Y2,NovaCoordenada).
getMoveCoordenada([X,Y|_],Direcao,NovaCoordenada) :- Direcao==3, Y2 is Y+1,getCoordenada(X,Y2,NovaCoordenada).

