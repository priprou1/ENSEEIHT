(* This file is generated by Why3's Coq driver *)
(* Beware! Only edit allowed sections below    *)
Require Import BuiltIn.
Require BuiltIn.

Parameter a: Prop.

Parameter b: Prop.

Parameter c: Prop.

(* Why3 goal *)
Theorem Thm03 : (a -> b) -> ~ b -> ~ a.
Proof.
intros h1 h2.
tauto.
Qed.

