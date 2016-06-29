north(X) :- X is 0.
south(X) :- X is 1.
west(X) :- X is 2.
east(X) :- X is 3.

isDirecaoValida(Direcao) :- Direcao>=0,Direcao=<3.

parseDirecao(CharDirecao,0) :- CharDirecao == w.
parseDirecao(CharDirecao,1) :- CharDirecao == s.
parseDirecao(CharDirecao,2) :- CharDirecao == a.
parseDirecao(CharDirecao,3) :- CharDirecao == d.