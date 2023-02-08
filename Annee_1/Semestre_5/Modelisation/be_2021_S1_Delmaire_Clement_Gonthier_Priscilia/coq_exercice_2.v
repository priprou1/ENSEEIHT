Require Import Naturelle.
Section Session1_2021_Logique_Exercice_2.

Variable A B C : Prop.

Theorem Exercice_2_Naturelle : ((A /\ B) -> C) -> ((A -> C) \/ (B -> C)).
Proof.
I_imp H.
E_ou (A->C) (~(A->C)).
TE.
I_imp AC.
I_ou_g.
Hyp AC.
I_imp nonAC.
I_ou_d.
I_imp HB.
E_imp (A/\B).
Hyp H.
I_et.
absurde nonA.
E_non (A->C).
I_imp HA.
E_antiT.
E_non A.
Hyp HA.
Hyp nonA.
Hyp nonAC.
Hyp HB.

Qed.

Theorem Exercice_2_Coq : ((A /\ B) -> C) -> ((A -> C) \/ (B -> C)).
Proof.
intro H.


Qed.

End Session1_2021_Logique_Exercice_2.

