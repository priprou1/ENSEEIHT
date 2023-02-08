(* Les règles de la déduction naturelle doivent être ajoutées à Coq. *) 
Require Import Naturelle. 

(* Ouverture d'une section *) 
Section LogiqueProposition. 

(* Déclaration de variables propositionnelles *) 
Variable A B C E Y R : Prop. 

Theorem Thm_0 : A /\ B -> B /\ A.
I_imp HAetB.
I_et.
E_et_d A.
Hyp HAetB.
E_et_g B.
Hyp HAetB.
Qed.

Theorem Thm_1 : ((A \/ B) -> C) -> (B -> C).
I_imp H.
I_imp HetB.
E_imp (A \/ B).
Hyp H.
I_ou_d.
Hyp HetB.
Qed.


Theorem Thm_2 : A -> ~~A.
I_imp a.
I_non nonA.
E_non A.
Hyp a.
Hyp nonA.
Qed.

Theorem Thm_3 : (A -> B) -> (~B -> ~A).
I_imp H1.
I_imp nonB.
I_non a.
E_non B.
E_imp A.
Hyp H1.
Hyp a.
Hyp nonB.
Qed.

Theorem Thm_4 : (~~A) -> A.
I_imp nonnonA.
absurde nonA.
E_non (~A).
Hyp nonA.
Hyp nonnonA.
Qed.

Theorem Thm_5 : (~B -> ~A) -> (A -> B).
I_imp H.
I_imp a.
absurde nonB.
E_non A.
Hyp a.
E_imp (~B).
Hyp H.
Hyp nonB.
Qed.

Theorem Thm_6 : ((E -> (Y \/ R)) /\ (Y -> R)) -> ~R -> ~E.
I_imp H.
I_imp nonR.
I_non e.
E_non R.
E_ou Y R.
E_imp E.
E_et_g (Y -> R).
Hyp H.
Hyp e.
E_et_d (E -> (Y \/ R)).
Hyp H.
I_imp r.
Hyp r.
Hyp nonR.
Qed.

(* Version en Coq *)

Theorem Coq_Thm_0 : A /\ B -> B /\ A.
intro H.                (* introduction implication *)
destruct H as (HA,HB).  (* élimination conjonction *)
split.                  (* introduction conjonction *)
exact HB.               (* hypothèse *)
exact HA.               (* hypothèse *)
Qed.


Theorem Coq_E_imp : ((A -> B) /\ A) -> B.
intro H.
destruct H as (HAB ,HA).
cut A.
exact HAB.
exact HA.
Qed.

Theorem Coq_E_et_g : (A /\ B) -> A.
intro HAB.
destruct HAB as (HA, HB).
exact HA.
Qed.

Theorem Coq_E_ou : ((A \/ B) /\ (A -> C) /\ (B -> C)) -> C.
intro H.
destruct H as (HAouB ,HACetBC).
destruct HACetBC as (HAC, HBC).
destruct HAouB as [HA | HB].
cut A.
exact HAC.
exact HA.
cut B.
exact HBC.
exact HB.
Qed.

Theorem Coq_Thm_7 : ((E -> (Y \/ R)) /\ (Y -> R)) -> (~R -> ~E).
intro H.
intro nonR.
destruct H as (H1, HYR).
unfold not.
intro e.
absurd R.
exact nonR.
cut Y.
exact HYR.
destruct H1 as [y | r].
exact e.
exact y.
absurd R.
exact nonR.
exact r.

Qed.

End LogiqueProposition.

