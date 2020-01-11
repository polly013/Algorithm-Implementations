% generate natural numbers
nat(0).
nat(A) :- nat(B), A is B+1.

% generate all x mod 3 == 2
gen3(2).
gen3(A) :- gen3(B), A is B+3.

% length of list
len([], 0).
len([_|Ls], Length) :- len(Ls, Length0),Length is Length0+1.

% list equality predicate
list_eq([],[]).
list_eq([A|T1],[A|T2]) :- list_eq(T1, T2).

% sum of all elements in a list
sum([], 0).
sum([A|L], S) :- sum(L, S1), S is S1 + A.

% slice a list append2(A, B, L) -> A concat B = L
append2([], L, L).
append2([H|A], B, [H|R]) :- append2(A, B, R).

member2(A, [A|_]).
member2(A, [_|B]) :- member2(A, B).

between2(I, J, I) :- I =< J.
between2(I, J, K) :- I < J, I1 is I+1, between2(I1, J, K).

% a bc -> cba
reverse2([], []).
reverse2([A|L], R) :- reverse2(L, R1), append2(R1, [A], R).

permutation([],[]).
permutation([A|L1],L2) :- permutation(L1, SL), append2(X,Y,SL), append2(X,[A|Y],L2).

% is L monotonically increasing
mono([]).
mono([_]).
mono([A,B|L]) :- A<B, mono([B|L]).

mysort([], []).
mysort(L, R) :- permutation(L, R), mono(R).

edge(U, V, E) :- member2([U, V], E).
edge(U, V, E) :- member2([V, U], E).

path_cost([], 0).
path_cost([[_,_,C]|E], R) :- path_cost(E, R1), R is R1 + C.
% path_cost([[1,2,5],[2,3,1]], K).

%hamiltonian path in graph
non_hamiltonian(E, H) :- append2(_, [U,V|_], H), not(edge(U, V, E)).
hamiltonian(V, E, H) :- permutation(V, H), not(non_hamiltonian(E,H)).
connected(_, [_]).
connected(E, [U,V|H]) :- edge(U,V,E), connected(E,[V|H]).
hamiltonian2(V, E, H) :- permutation(V, H), connected(E, H).

%TODO:
%min hamiltonian path
edge3(U, V, E) :- member2([U, V, _], E).
edge3(U, V, E) :- member2([V, U, _], E).
non_hamiltonian3(E, H) :- append2(_, [U,V|_], H), not(edge3(U, V, E)).
hamiltonian3(V, E, H, C) :- permutation(V, H), not(non_hamiltonian3(E,H)), path_cost(H, C).
% ?- hamiltonian3([1,2,3],[[1,2,5],[3,1,10],[2,3,1]],X,Y).

% L - list, generate all sublists of L in S
% U + S + W = L
subword(L,S) :- append2(_,S,X),append2(X,_,L).
% L - list, generate all subsets of L in S
subset([],[]).
subset([A|L],[A|S]) :- subset(L,S).
subset([_|L],S) :- subset(L,S).

% G - graph, find max clique (max subset of nodes, for each (u, v) from V, exists (u, v) in E
is_not_clique(V, E) :- member2(A,V), member2(B,V), A\=B, not(edge(A,B,E)).
is_clique(V, E) :- not(is_not_clique(V, E)).
%?- is_clique([1,2,3,4],[[1,2],[3,4],[1,3],[3,2]]).

clique(V, E, V1) :- subset(V, V1), is_clique(V1, E).
bigger_clique(V, E, N) :- clique(V, E, V1), len(V1, M), M > N.
max_clique(V, E, V1) :- clique(V, E, V1), len(V1, S), not(bigger_clique(V, E, S)).

% find min chromatic number
is_not_colouring(E, C) :- edge(A, B, E), member2([A,K1], C), member2([B,K2], C), K1==K2.
is_colouring(E, C) :- not(is_not_colouring(E, C)).
%?- is_colouring([[1,2],[2,3],[3,4],[1,4]],[[1,a],[2,b],[3,a],[4,b]]).

% all functions g : V -> 1,...,K
all_functions([], [], _).
all_functions([A|V], [[A,B]|R], K) :- between2(1, K, B), all_functions(V, R, K).
colouring(V, E, C, K) :- all_functions(V, C, K), is_colouring(E, C).
% colouring([1,2,3,4],[[1,2],[2,3],[3,4],[1,4]],X,2).
min_colouring(V, E, C, K) :- len(V, N), between2(1, N, K), colouring(V, E, C, K), K1 is K-1, not(colouring(V, E, _, K1)).

% merge sort
split(_, _, []).
split([A], [], [A]).
split([A], [B], [A,B]).
split([A1|A], [B1|B], [A1,B1|L]) :- split(A, B, L).

merge(A, [], A).
merge([], B, B).
merge([A1|A], [B1|B], [A1|R]) :- A1 < B1, merge(A, [B1|B], R).
merge([A1|A], [B1|B], [B1|R]) :- A1 >= B1, merge([A1|A], B, R).

merge_sort([], []).
merge_sort([A], [A]).
merge_sort(S, R) :- split(A, B, S), merge_sort(A, A1), merge_sort(B, B1), merge(A1, B1, R).

% is graph strongly connected
is_not_sconnected(V, E) :- member2(U, V), member2(W, V), U \= W, not(edge(U, W, E)).
is_sconnected(V, E) :- not(is_not_sconnected(V, E)).

% generate all paths from A to B in a graph
path(E,Start,Stop,Path):- path1(E,Start,Stop,[Start],P), reverse2(P, Path).
path1(_,Stop,Stop,Path,Path).
path1(E,Start,Stop,CurrPath,Path):-
   Start\=Stop,
   edge(Start,Next,E),
   not(member2(Next,CurrPath)),
   path1(E,Next,Stop,[Next|CurrPath],Path).

% is graph connected
is_not_connected(V, E) :- member2(U, V), member2(W, V), U \= W, not(path(E, U, W, _)).
is_connected(V, E) :- not(is_not_connected(V, E)).
%?- is_connected([1,2,3,4],[[1,2],[2,3],[2,4],[1,3]]).

% generate all spanning trees
spanning_tree(V, E, T) :- subset(E, T), is_connected(V, T).

% generate cartesian product
gent([], _, []).
gent([X|L], A, [[A,X]|R]) :- gent(L, A, R).
cart([],_,[]).
cart([X|L1], L2, [R1|R]) :- gent(L2, X, R1), cart(L1, L2, R).

% generate all natural tuples
nat(A, B) :- nat(S), between2(0, S, A), B is S - A.

% generate all multipliers of a number
not_prime(1).
not_prime(N) :- N1 is N-1, between2(2,N1,K), d(N, K).
prime(N) :- not(not_prime(N)).
d(A, D) :- A mod D =:= 0.

range(A, A, [A]).
range(A, B, [A|R]) :- A < B, A1 is A+1, range(A1, B, R).

% multiplier filter
mult(_, [], []).
mult(N, [D|L], [D|R]) :- d(N, D), mult(N, L, R).
mult(N, [D|L], R) :- not(d(N,D)), mult(N, L, R).
% prime filter
prime_filter([], []).
prime_filter([D|L], [D|R]) :- prime(D), prime_filter(L, R).
prime_filter([D|L], R) :- not(prime(D)), prime_filter(L, R).

mult(N, R) :- range(1, N, L), mult(N, L, R).
% generate all prime multipliers of a number
pmult(N, R) :- mult(N, R1), prime_filter(R1, R).
first_prime_mult(N, P) :- mult(N, [_,P|_]).

% cycle detection in graph
cycle(_, A, A, _).
cycle(E, A, B, UsedEdges) :- edge(A, X, E),
    not(member2([A, X], UsedEdges)), not(member2([X, A], UsedEdges)),
    cycle(E, X, B, [[A,X]|UsedEdges]).
is_cycle(E, A) :- edge(A, B, E), cycle(E, A, B, [[A, B]]).
is_cyclic(V, E) :- member2(U, V), is_cycle(E, U).
is_acyclic(V, E) :- not(is_cyclic(V, E)).
% ?- is_acyclic([1,2,3,4,5,6],[[1,2],[1,3],[2,4],[2,5],[4,6],[3,4]]).
