%%%%define constantes enumeradas
territorio(X) :- X is 0.
espiao(X) :- X is 1.
soldado(X) :- X is 2.
cabo(X) :- X is 3.
sargento(X) :- X is 4.
tenente(X) :- X is 5.
capitao(X) :- X is 6.
major(X) :- X is 7.
coronel(X) :- X is 8.
general(X) :- X is 9.
marechal(X) :- X is 10.
bomba(X) :- X is 11.
bandeira(X) :- X is 12.

%%%%compara peças
%;0 igual
%;1 primeira maior que segunda
%;-1 primeira menor que segunda
comparePiece(A,B,1) :- A>B,!.
comparePiece(A,B,-1) :- A<B,!.
comparePiece(A,B,0) :- A==B.

%%%%
isPieceEquals(A,B) :- comparePiece(A,B,R), R == 0.


%%%%%normaliza a peça
normalizePiece(P,R) :- P >= 100, R is P-100.
normalizePiece(P,R) :- P < 100, R is P.

%%%%%obtém inimigo
getEnemyPiece(P,R) :- P < 100, R is P+100.
getEnemyPiece(P,R) :- P >= 100, R is P.


%%responde se a peça pertence ao jogador dado
isMyPiece(P,T) :- P >= 100, T == 2,territorio(Te), not(isPieceEquals(P,Te)).
isMyPiece(P,T) :- P < 100, T == 1, territorio(Te), not(isPieceEquals(P,Te)).


%%%%%responde se a primeira peça ganha a batalha contra a segunda
wonInvestida(A,B) :- normalizePiece(B,B1), bandeira(Bandeira), B1 == Bandeira,!.
wonInvestida(A,B) :- normalizePiece(A,A1), normalizePiece(B,B1), cabo(Cabo), bomba(Bomba), A1 == Cabo, B1 == Bomba.
wonInvestida(A,B) :- normalizePiece(A,A1), normalizePiece(B,B1), espiao(Espiao), marechal(Marechal), A1 == Espiao, B1 == Marechal.
wonInvestida(A,B) :- normalizePiece(A,A1), normalizePiece(B,B1), comparePiece(A1,B1,R), R >= 0.


%%%%%converte uma peça para string
toString(P,"   ") :- territorio(X), X == P.
toString(P,"ESP") :- espiao(X), X == P.
toString(P,"SOL") :- soldado(X), X == P.
toString(P,"CAB") :- cabo(X), X == P.
toString(P,"SGT") :- sargento(X), X == P.
toString(P,"TEN") :- tenente(X), X == P.
toString(P,"CPT") :- capitao(X), X == P.
toString(P,"MAJ") :- major(X), X == P.
toString(P,"CEL") :- coronel(X), X == P.
toString(P,"GEN") :- general(X), X == P.
toString(P,"MAR") :- marechal(X), X == P.
toString(P,"@@@") :- bomba(X), X == P.
toString(P,"+++") :- bandeira(X), X == P.


