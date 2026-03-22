%Type 0

adj(X,Y,X',Y') :- cell(X,Y,R), cell(X',Y',R'), X' = X+1, Y' = Y.
adj(X,Y,X',Y') :- cell(X,Y,R), cell(X',Y',R'), Y' = Y+1, X' = X.

{stitch(X,Y,X',Y')} :- adj(X,Y,X',Y').

% 1. Each stitch must connect two different regions 
:- stitch(X,Y,X',Y'), cell(X,Y,R), cell(X',Y',R).

% 2. Two stitches cannot share a hole 
:- stitch(X,Y,X1,Y1), stitch(X,Y,X2,Y2), (X1,Y1)!=(X2,Y2).
:- stitch(X1,Y1,X,Y), stitch(X2,Y2,X,Y), (X1,Y1)!=(X2,Y2).
% 3. Every pair of adjacent regions must be connected by a fixed number M>0 of stitches
regions_adj(R,R') :- cell(X,Y,R), cell(X',Y',R'), adj(X,Y,X',Y'), R < R'.
:- regions_adj(R,R'), m(M), not M { stitch(X,Y,X',Y') : cell(X,Y,R),  cell(X',Y',R'), adj(X,Y,X',Y'); stitch(X,Y,X',Y') : cell(X,Y,R'), cell(X',Y',R),  adj(X,Y,X',Y')} M.

% 4. The numbers in the upmost row indicate the total number of holes per each column
hole(X,Y) :- stitch(X,Y,X',Y').
hole(X,Y) :- stitch(X',Y',X,Y).

:- colholes(C,N), not N { hole(X,C) : cell(X,C,R) } N.

% 5. The numbers in the leftmost column indicate the number of holes per each row 
:- rowholes(F,N), not N { hole(F,Y) : cell(F,Y,R) } N.

#show stitch/4.