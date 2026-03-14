%Type 0

% Este pareceme complicar o tema un pouco
% adjacent mostra que celdas adllacentes forman o stitch, asegurandose que sean de regions distintas
% { h_stitch(X,Y) : h_adjacent(X,Y,Y'), cell(X,Y,R), cell(X,Y',R'), R != R' }.
% { v_stitch(X,Y) : v_adjacent(X,X',Y), cell(X,Y,R), cell(X',Y,R'), R != R' }.


%%%%%%% Non sei se meter esto aqui ou se ten que ir en domXX.lp, por ahora queda aqui / en principio vai en dom.lp
row(1..N).
col(1..N).
region(X,Y,R).     % región de cada celda
adj(X,Y,X',Y').    % celdas adyacentes
row_holes(F,N).    % agujeros por fila
col_holes(C,N).    % agujeros por columna
m(M).
{stitch(X,Y,X1,Y1)}.

% 1. Each stitch must connect two different regions 
:- stitch(X,Y,X',Y'), region(X,Y,R), region(X',Y',R).

% 2. Two stitches cannot share a hole 
:- stitch(X,Y,X1,Y1), stitch(X2,Y2,X3,Y3), (X1,Y1)!=(X3,Y3), (X,Y)!=(X2,Y2), (X1,Y1)!=(X2,Y2), (X,Y)!=(X3,Y3).

% 3. Every pair of adjacent regions must be connected by a fixed number M>0 of stitches
adj_regions(R1,R2) :- region(X,Y,R1), region(X',Y',R2), adj(X,Y,X',Y'), R1 < R2.
:- adj_regions(R1,R2), m(M), not M {stitch(A,B,C,D) : region(A,B,R1), region(C,D,R2)} M.

% 4. The numbers in the upmost row indicate the total number of holes per each column
:- col_holes(C,N), not N { stitch(X,C,X',Y') ; stitch(X,Y,X',C) } N.

% 5. The numbers in the leftmost column indicate the number of holes per each row 
:- row_holes(F,N), not N {stitch(F,Y,X',Y') ; stitch(X,Y,F,Y')} N.

#show stitch/4.