with AB_Exceptions; use AB_Exceptions;
with Ada.Text_IO.Unbounded_IO;use Ada.Text_IO.Unbounded_IO;
with Ada.Text_IO;           use Ada.Text_IO;

package body TAB_HUFF is

    procedure Initialiser(tab_huff : out T_TAB_HUFF) is
    begin
        tab_huff.Taille := 0;
    end Initialiser;


    function Est_vide(tab_huff: in T_TAB_HUFF) return Boolean is
    begin
        return tab_huff.Taille = 0;
    end Est_vide;


    function Taille_table(tab_huff: in T_TAB_HUFF) return Integer is
    begin
        return tab_huff.Taille;
    end Taille_table;


    procedure Creer_Table(tab_huff: in out T_TAB_HUFF; AB: in T_AB) is

        procedure Creer_Table_aux(tab_huff: in out T_TAB_HUFF; AB: in T_AB; Code: in Unbounded_String) is
            ss_ab_g : T_AB;
            ss_ab_d : T_AB;
        begin

            if not(Est_vide_AB(AB)) then
                Sous_Arbre_Gauche(ss_ab_g, AB);
                Sous_Arbre_Droit(ss_ab_d, AB);
                if Est_vide_AB(ss_ab_g) and then Est_vide_AB(ss_ab_d) then
                    tab_huff.Taille := tab_huff.Taille + 1;
                    tab_huff.Tableau(tab_huff.Taille).Caractere := Caractere_Racine(AB);
                    tab_huff.Tableau(tab_huff.Taille).Code := Code;
                else
                    Creer_Table_aux(tab_huff, ss_ab_g, Code & '0');
                    Vider_AB(ss_ab_g);
                    Creer_Table_aux(tab_huff, ss_ab_d, Code & '1');
                    Vider_AB(ss_ab_d);

                end if;
            end if;
        end Creer_Table_aux;

    begin
        Creer_Table_aux(tab_huff, AB, To_Unbounded_String("") );
    end Creer_Table;


    function Code_Indice(Tab_Huff: in out T_Tab_Huff; Indice : in Integer) return Unbounded_String is
    begin
        return Tab_Huff.Tableau(Indice).Code;
    end Code_Indice;


    function Caractere_Indice(Tab_Huff : in out T_Tab_Huff; Indice : in Integer) return T_Char is
    begin
        return Tab_Huff.Tableau(Indice).Caractere;
    end Caractere_Indice;


    function Table_Code(Tab_Huff : in T_Tab_Huff ; Char: in T_Char) return Unbounded_String is
        Char_Abs : Boolean := True;
    begin
        for i in 1..Tab_Huff.Taille loop
            if Tab_Huff.Tableau(i).Caractere = Char then
                Char_Abs := False;
                return Tab_Huff.Tableau(i).Code;
            end if;
        end loop;

        if Char_Abs then
           raise Char_Absent_Exception;
        end if;
    end Table_Code;


    procedure Afficher_Table(Tab_Huff : in T_Tab_Huff) is
    begin
        for i in 1..Tab_Huff.Taille loop
            Put("'");
            if Tab_Huff.Tableau(i).Caractere = -1 then
                Put("\$");
            elsif Tab_Huff.Tableau(i).Caractere = 10 then
                Put("\n");
            else
                Put(Character'Val(Tab_Huff.Tableau(i).Caractere));
            end if;
            Put("'");
            Put(" --> ");
            Put(Tab_Huff.Tableau(i).Code);
            New_Line;
        end loop;
    end Afficher_Table;


    function Table_Indice(Tab_Huff : in T_Tab_Huff ; Char: in T_Char) return Integer is
        Char_Abs : Boolean := True;
    begin
        for i in 1..Tab_Huff.Taille loop
            if Tab_Huff.Tableau(i).Caractere = Char then
                Char_Abs := False;
                return i;
            end if;
        end loop;

        if Char_Abs then
           raise Char_Absent_Exception;
        end if;
    end Table_Indice;

end TAB_HUFF;
