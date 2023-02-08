Require Import Naturelle.
Section Session1_2021_Logique_Exercice_1.

Variable A B C : Prop.

Theorem Exercice_1_Naturelle :  ((A -> C) \/ (B -> C)) -> ((A /\ B) -> C).
Proof.
I_imp H.
I_imp AetB.
E_imp B.
E_ou (A->C)(B->C).
Hyp H.
I_imp AC.
I_imp b.
E_imp A.
Hyp AC.
E_et_g B.
Hyp AetB.
I_imp BC.
Hyp BC.
E_et_d A.
Hyp AetB.

Qed.


Theorem Exercice_1_Coq : ((A -> C) \/ (B -> C)) -> ((A /\ B) -> C).
Proof.
intro H.
intro AetB.
cut B.
elim H.
intro AC.
intro b.
cut A.
exact AC.
cut (A/\B).
intro H1.
elim H1.
intros HA HB.
exact HA.
exact AetB.
intro BC.
exact BC.
cut (A/\B).
intro H1.
elim H1.
intros HA HB.
exact HB.
exact AetB.

Qed.

End Session1_2021_Logique_Exercice_1.

