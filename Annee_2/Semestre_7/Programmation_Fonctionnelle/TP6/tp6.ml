type zero = private Dummy1
type _ succ = private Dummy2
type nil = private Dummy3
type 'a list = Nil | Cons of 'a * 'a list

(* Exo 1 :*)
type (_, _) nlist =
  | Nil : ('a,zero) nlist
  | Cons : 'a * ('a, 'n) nlist -> ('a, 'n succ) nlist

let rec map : type n.('a -> 'b) -> ('a, n) nlist -> ('b, n) nlist 
  = fun f -> function
  | Nil -> Nil
  | Cons(t, q) -> Cons(f t, map f q)

let rec snoc : type n. 'a -> ('a, n) nlist -> ('a, n succ) nlist
  = fun e -> function
  | Nil -> Cons(e, Nil)
  | Cons(t, q) -> Cons(t, snoc e q)

let tail : type n.('a, n succ) nlist -> ('a, n) nlist
  = function Cons(_, q) -> q

let rec rev : type n.('a, n) nlist -> ('a, n) nlist =
  function
  | Nil -> Nil
  | Cons(t,q) -> snoc t (rev q)

(* Exo 2 : *)
let rec insert : type n.'a -> ('a, n) nlist -> ('a, n succ) nlist =
  fun e l -> match l with
  | Nil -> Cons(e, Nil)
  | Cons(t,q) -> if t < e then Cons(t, insert e q) else Cons(e, l) ;;

let rec insertion_sort : type n.('a, n) nlist -> ('a, n) nlist  =
  function
  | Nil -> Nil
  | Cons(t,q) -> insert t (insertion_sort q );;

(* Exo 3 : *)
type _ hlist = 
  | Nil : nil hlist
  | Cons : 't * 'q hlist -> ('t * 'q) hlist

let htail : type a.(a * 't) hlist -> 't hlist =
  function Cons (_, q) -> q

let add : (int*(int*'t)) hlist -> (int*'t) hlist =
  function
  | Cons ( i1, Cons (i2, q)) -> Cons (i1+i2, q)