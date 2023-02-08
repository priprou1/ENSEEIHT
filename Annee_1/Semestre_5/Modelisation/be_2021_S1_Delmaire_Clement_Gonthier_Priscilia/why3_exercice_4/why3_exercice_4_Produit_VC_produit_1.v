(* This file is generated by Why3's Coq driver *)
(* Beware! Only edit allowed sections below    *)
Require Import BuiltIn.
Require BuiltIn.
Require int.Int.

(* Why3 assumption *)
Inductive ref (a:Type) :=
  | mk_ref : a -> ref a.
Axiom ref_WhyType : forall (a:Type) {a_WT:WhyType a}, WhyType (ref a).
Existing Instance ref_WhyType.
Arguments mk_ref {a}.

(* Why3 assumption *)
Definition contents {a:Type} {a_WT:WhyType a} (v:ref a) : a :=
  match v with
  | mk_ref x => x
  end.

(* Why3 goal *)
Theorem VC_produit :
  forall (a:Z) (b:Z),
  ((b < 0%Z)%Z -> forall (la:Z), (la = (-a)%Z) -> forall (lb:Z),
   (lb = (-b)%Z) ->
   ((0%Z = (la * 0%Z)%Z) /\ (0%Z <= (lb - 0%Z)%Z)%Z) /\
   forall (i:Z) (s:Z), ((s = (la * i)%Z) /\ (0%Z <= (lb - i)%Z)%Z) ->
   ((i < lb)%Z -> forall (s1:Z), (s1 = (s + la)%Z) -> forall (i1:Z),
    ~ (i1 = (i + 1%Z)%Z)) /\
   (~ (i < lb)%Z -> ((a * b)%Z = s))) /\
  (~ (b < 0%Z)%Z ->
   ((0%Z = (a * 0%Z)%Z) /\ (0%Z <= (b - 0%Z)%Z)%Z) /\
   forall (i:Z) (s:Z), ((s = (a * i)%Z) /\ (0%Z <= (b - i)%Z)%Z) ->
   ((i < b)%Z -> forall (s1:Z), (s1 = (s + a)%Z) -> forall (i1:Z),
    ~ (i1 = (i + 1%Z)%Z)) /\
   (~ (i < b)%Z -> ((a * b)%Z = s))).
Proof.
intros a b.

Qed.
