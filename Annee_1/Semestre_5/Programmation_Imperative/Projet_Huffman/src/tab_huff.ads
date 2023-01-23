with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with AB; use AB;

-- Définition de la table de Huffman.
package TAB_HUFF is
    type T_TAB_HUFF is limited private;


    -- Initialiser une table de Huffman vide
    procedure Initialiser(tab_huff : out T_TAB_HUFF) with
            Post => Est_Vide(tab_huff);


    -- Est-ce qu'une table de Huffman est vide ?
    function Est_vide(tab_huff: in T_TAB_HUFF) return Boolean;


    -- Renvoyer la taille de la table de Huffman en paramètre
    function Taille_table(tab_huff: in T_TAB_HUFF) return Integer with
            Post => 0 <= Taille_table'Result ;


    -- Créer une table de Huffman à partir d'un arbre de Huffman
    procedure Creer_Table(tab_huff: in out T_Tab_Huff; AB: in T_AB) with
            Pre => Est_vide(Tab_huff);


    -- Renvoyer le code dans la cellule associée à la case du tableau d’indice donné en paramètre
    function Code_Indice(Tab_Huff: in out T_Tab_Huff; Indice : in Integer) return Unbounded_String with
            Pre => 1 <= Indice and Indice <= Taille_table(tab_huff);


    -- Renvoyer le caractère dans la cellule associée à la case du tableau d’indice donné en paramètre
    function Caractere_Indice(Tab_Huff : in out T_Tab_Huff; Indice : in Integer) return T_Char with
            Pre => 1 <= Indice and Indice <= Taille_table(tab_huff);


    -- Renvoyer le code de Huffman du caractère passé en argument
    -- Exception quand le caractère n'est pas dans la table
    function Table_Code(Tab_Huff : in T_Tab_Huff ; Char: in T_Char) return Unbounded_String;


    -- Afficher la table de Huffman donnée en paramètre comme la figure 21 p.11 de l’énoncé
    procedure Afficher_Table(Tab_Huff : in T_Tab_Huff);


    -- Renvoyer la position d’un caractère dans la table
    -- Exception quand le caractère n'est pas dans la table
    function Table_Indice(Tab_Huff: in T_Tab_Huff; Char : in T_Char) return Integer with
            Post => 0 <= Table_Indice'Result and Table_Indice'Result <= Taille_table(Tab_Huff);

private

    type T_Cellule_Code is record
        Caractere: T_Char;
        Code: Unbounded_String;
    end record;

    type T_TAB is array (1..CAPACITE) of T_Cellule_Code;

    type T_TAB_HUFF is record
        Tableau: T_TAB;
        Taille: Integer;
    end record;

end TAB_HUFF;
