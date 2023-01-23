-- Définition d'arbre (structure de données associatives sous forme d'une liste
-- chaînée associative) (AB).

with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;

package AB is

    type T_AB is limited private;

    TYPE T_Char is new Integer;

    CAPACITE : Integer := 257;

    -- Initialiser un Arbre. L'arbre est vide.
    procedure Initialiser_AB(AB : out T_AB) with
            Post => Est_Vide_AB(AB);

    -- Est-ce qu'un arbre est vide ?
    function Est_vide_AB(AB : in T_AB) return Boolean;

    -- Obtenir le nombre d'éléments d'un arbre.
    function Taille(AB : in T_AB) return Integer with
            Post => Taille'Result >= 0
            and (Taille'Result = 0) = Est_vide_AB(AB);

    -- Tester si 2 arbres sont égaux.
    function Est_Egal(AB_1 : in T_AB; AB_2 : in T_AB) return Boolean;

    -- Enregistrer un caractère associé à sa fréquence dans un arbre.
    -- Si le caractère est déjà présent dans l'arbre, sa fréquence est changée.
    procedure Enregistrer_AB(AB : in out T_AB; Char : T_Char; Frequence : Integer)with
            Post => Char_Present(AB, Char) and (La_Frequence(AB, Char) = Frequence)
            and (not (Char_Present (AB, Char)'Old) or Taille (AB) = Taille (AB)'Old)
            and (Char_Present (AB, Char)'Old or Taille (AB) = Taille (AB)'Old + 1);

    -- Supprimer la fréquence associée à un caractère dans un arbre.
    -- Exception : Char_Absent_Exception si Char n'est pas utilisée dans l'arbre
    procedure Supprimer_AB(AB : in out T_AB; Char : in T_Char) with
            Post => Taille (AB) = Taille (AB)'Old - 1
            and not Char_Present (AB, Char);

    -- Savoir si un caractère est présent dans un arbre.
    function Char_Present(AB : in T_AB; Char : in T_Char) return Boolean;

    -- Obtenir la fréquence associée à un caratère dans l'arbre.
    -- Exception : Char_Absent_Exception si Char n'est pas utilisé dans l'arbre.
    function La_Frequence(AB : in T_AB; Char : in T_Char) return Integer;

    -- Vider un arbre donné en paramètre.
    procedure Vider_AB(AB : in out T_AB) with
            Post => Est_vide_AB(AB);

    -- Donner la fréquence de la racine de l'arbre donné en paramètre.
    function Frequence_Racine(AB : T_AB) return Integer with
            Pre => not Est_vide_AB(AB),
            Post => Frequence_Racine'Result >=0;

    -- Donner la racine de l'arbre donné en paramètre
    function Caractere_Racine(AB : T_AB) return T_Char with
            Pre => not Est_vide_AB(AB);

    -- Copier un arbre AB dans un autre arbre AB_Copie
    procedure Copier_AB(AB : in T_AB; AB_Copie : in out T_AB);

    -- Fusionner 2 sous-arbres.
    procedure Fusionner_AB(AB_cree : out T_AB; AB_Gauche : in T_AB; AB_Droit : in T_AB) with
            Post => Taille(AB_cree) = Taille(AB_Gauche) + Taille(AB_Droit);

    -- Extraire le sous-arbre gauche d'un arbre
    procedure Sous_Arbre_Gauche(AB_g : out T_AB; AB : in T_AB) with
            Pre => not Est_vide_AB(AB),
            Post => Taille(AB) >= Taille(AB_g);

    -- Extraire le sous-arbre droit d'un arbre
    procedure Sous_Arbre_Droit(AB_d : out T_AB; AB : in T_AB) with
            Pre => not Est_vide_AB(AB),
            Post => Taille(AB) >= Taille(AB_d);

    -- Afficher l'arbre de Huffman comme la figure 20 p 11 de l'énoncé
    procedure Afficher_AB(AB : in T_AB);

    -- Créer un Arbre de Huffman sous la forme d’une suite de 0 et de 1, correspondant au parcours infixe de l’arbre
    function Code_AB(AB : in T_AB) return Unbounded_String;

    -- Définition du type T_TAB_CAR
    type T_TAB is array (1..CAPACITE) of T_Char;

    type T_TAB_CAR is record
        Tableau : T_TAB;
        Taille : Integer;
    end record;

    -- Créer l’arbre de Huffman correspondant au code de l’arbre de Huffman et de la table des caractères en paramètre
    procedure Creer_AB_Huff(AB : out T_AB; Tab_Car : in T_TAB_CAR; Code_AB: in out Unbounded_String);

private
    type T_Cellule;
    type T_AB is access T_Cellule;
    type T_Cellule is record
        Frequence : Integer;
        Caractere : T_Char;
        Arbre_Gauche : T_AB;
        Arbre_Droit : T_AB;
    end record;

end AB;


