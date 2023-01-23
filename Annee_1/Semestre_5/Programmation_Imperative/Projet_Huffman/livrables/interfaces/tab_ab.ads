-- Définition de tableau de T_AB.

with AB; use AB;

package TAB_AB is

    type T_TAB_AB is limited private;


    -- Initialiser un tableau d'arbres binaires vide
    procedure Initialiser(Tab : out T_TAB_AB) with
            Post => Est_Vide(Tab);


    -- Est-ce qu'un tableau d'arbre est vide ?
    function Est_vide(Tab : in T_TAB_AB) return Boolean;


    -- Indiquer si un des arbres du tableau contient le caractère donné en paramètre
    function Caractere_Present(Tab: in T_TAB_AB; Char: in T_Char) return Boolean;


    -- Donner l’indice du tableau où l'arbre se trouve un caractère
    function Indice_Character(Tab: in T_TAB_AB; Char: in T_Char) return Integer with
            Pre => Caractere_Present(Tab, Char);


    -- Retourner la fréquence du caractère en paramètre dans un des arbres du tableau
    function Frequence_Character(Tab: in T_TAB_AB; Char: in T_Char) return Integer with
            Post => Frequence_Character'Result >= 0;


    -- Retourner la fréquence de la racine de l’arbre à la position i dans le tableau
    function Frequence_Indice(Tab: in T_TAB_AB; Indice: in Integer) return Integer with
            Pre => 1 <= Indice and Indice <= Taille(Tab),
            Post => FREQUENCE_INDICE'Result >= 0;


    -- Supprimer du tableau l’arbre à la position donnée en paramètre
    procedure Supprimer(Tab: in out T_TAB_AB; Position: in Integer) with
            Post => Taille (Tab)'Old = Taille (Tab) + 1;


    -- Ajouter dans le tableau un arbre contenant seulement le caractère associé à la fréquence tous deux en paramètre
    procedure Enregistrer(Tab: in out T_TAB_AB; Char: in T_Char; Frequence: in Integer) with
            Post => Caractere_Present(Tab, Char) and Frequence_Character(Tab, Char) = Frequence;


    -- Ajouter dans le tableau un arbre donné en paramètre
    procedure Ajouter(Tab: in out T_TAB_AB; AB: in T_AB) with
            Post => Taille (Tab)'Old + 1 = Taille (Tab);


    -- Renvoyer la taille du tableau en paramètre
    function Taille(Tab: in T_TAB_AB) return Integer with
            Post => Taille'Result >= 0
                    and ((Taille'Result = 0) = Est_vide(Tab));


    -- Créer un arbre dont le sous-arbre gauche est l’arbre en position i1 du tableau et le sous-arbre droit est l’arbre en position i2
    -- Supprimer les deux sous-arbres du tableau et place l’arbre créé dans le tableau
    procedure Regrouper(Tab: in out T_TAB_AB; i1: in Integer; i2: in Integer) with
            Pre => (1 <= i1 and i1 <= Taille(Tab)) and (1 <= i2 and i2 <= Taille(Tab)),
            Post => Taille(Tab)'Old = Taille(Tab) + 1;


    -- Copier l’arbre de Tab situé à l’indice demandé dans un deuxième arbre
    procedure Copier(Tab: in T_TAB_AB; Indice: in Integer; ab: in out T_AB) with
            Pre => 1 <= Indice and Indice <= Taille(Tab);


    procedure Vider(Tab: in out T_TAB_AB) with
            Post => Est_vide (Tab);


private
    type T_TAB is array (1..CAPACITE) of T_AB;

    type T_TAB_AB is record
        Tableau: T_TAB;
        Taille: Integer;
    end record;

end TAB_AB;
