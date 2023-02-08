Section Session1_2021_Induction_Exercice_3.

(* Déclaration d’un domaine pour les éléments des listes *)
Variable A : Set.

(* Définition du type inductif représentant les entiers naturels *) 
Inductive naturel : Set :=
  Zero : naturel
  | Succ : naturel -> naturel.

(* Déclaration du nom de la fonction somme *)
Variable somme_spec : naturel -> naturel -> naturel.

(* Spécification du comportement de somme pour Zero en premier paramètre *)
Axiom somme_Zero : forall (n : naturel), (somme_spec Zero n) = n.

(* Spécification du comportement de somme pour Succ en premier paramètre *)
Axiom somme_Succ : forall (n m : naturel), (somme_spec (Succ n) m) = (Succ (somme_spec n m)).

(* Preuve du comportement de somme pour Zero en second paramètre *)
Theorem somme_Zero_droite : forall (v : naturel), (somme_spec v Zero) = v.
induction v.
rewrite somme_Zero.
reflexivity.
rewrite somme_Succ.
rewrite IHv.
reflexivity.

Qed.

(* Preuve du comportement de somme pour Succ en second paramètre *)
Theorem somme_Succ_droite : forall (n m : naturel), (somme_spec m (Succ n))= (Succ (somme_spec m n)).
induction m.
rewrite ->somme_Zero.

rewrite somme_Zero.
reflexivity.
rewrite somme_Succ.
rewrite IHm.
rewrite <-somme_Succ.
reflexivity.

Qed.

(* Preuve que somme est commutative *)
Theorem somme_commutative : forall (n m : naturel), (somme_spec m n)= (somme_spec n m).
Proof.
induction m.
rewrite somme_Zero_droite.
rewrite somme_Zero.
reflexivity.
rewrite somme_Succ.
rewrite somme_Succ_droite.
rewrite IHm.
reflexivity.

Qed.

(* Implantation de la fonction somme *)
Fixpoint somme_impl (v1 v2 : naturel) {struct v1} : naturel :=
match v1 with
  Zero => v2
  | Succ v => Succ (somme_impl v v2)
end.

(* Preuve que l'implantation de la fonction somme est correcte *)
Theorem somme_correcte : forall (v1 v2 : naturel),
   (somme_spec v1 v2) = (somme_impl v1 v2).
Proof.
induction v1.
intro v2.
rewrite somme_Zero.
simpl.
reflexivity.
intro v2.
rewrite somme_Succ.
simpl.
rewrite IHv1.
reflexivity.

Qed.

End Session1_2021_Induction_Exercice_3.
