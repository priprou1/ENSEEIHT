with AB_Exceptions; use AB_Exceptions;
with Ada.Unchecked_Deallocation;
with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Integer_Text_IO;       use Ada.Integer_Text_IO;

package body AB is

    procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_AB);

    procedure Initialiser_AB(AB : out T_AB) is
    begin
        AB := null;
    end Initialiser_AB;

    function Est_vide_AB(AB : in T_AB) return Boolean is
    begin
        return AB = null;
    end Est_vide_AB;

    function Taille(AB : in T_AB) return Integer is
    begin
        if AB = null then
            return 0;
        elsif AB.all.Caractere /= -2 then
            return 1;
        else
            return Taille(AB.all.Arbre_Gauche) + Taille(AB.all.Arbre_Droit);
        end if;
    end Taille;

    function Est_Egal(AB_1 : in T_AB; AB_2 : in T_AB) return Boolean is
    begin
        if AB_1 = null and then AB_2 = null then
            return True;
        elsif AB_1 = null then
            return False;
        elsif AB_2 = null then
            return False;
        elsif AB_1.all.Caractere = AB_2.all.Caractere then
            return Est_Egal(AB_1.all.Arbre_Gauche, AB_2.all.Arbre_Gauche) and Est_Egal(AB_1.all.Arbre_Droit, AB_2.all.Arbre_Droit);
        else
            return False;
        end if;
    end Est_Egal;

    procedure Enregistrer_AB(AB : in out T_AB; Char : in T_Char; Frequence : in Integer) is
        procedure Enregistrer_char_present(AB : in out T_AB; Char : in T_Char; Frequence_Nouvelle : in Integer; Frequence_Ancienne : in Integer) is
        begin
            if AB.all.Caractere = -2 then
                AB.all.Frequence := AB.all.Frequence - Frequence_Ancienne + Frequence_Nouvelle;
                Enregistrer_char_present(AB.all.Arbre_Gauche, Char, Frequence_Nouvelle, Frequence_Ancienne);
                Enregistrer_char_present(AB.all.Arbre_Droit, Char, Frequence_Nouvelle, Frequence_Ancienne);
            elsif AB.all.Caractere = Char then
                AB.all.Frequence := Frequence_Nouvelle;
            end if;
        end Enregistrer_char_present;

        AB_g : T_AB;
        AB_d : T_AB;
        Frequence_Ancienne : Integer;
    begin
        if AB = null then
            AB := new T_Cellule;
            AB.all.Frequence := Frequence;
            AB.all.Caractere := Char;
            AB.all.Arbre_Gauche := null;
            AB.all.Arbre_Droit := null;
        elsif not Char_Present(AB, Char) then
            AB_g := AB;
            AB := new T_Cellule;
            AB_d := new T_Cellule;
            AB_d.all.Caractere := Char;
            AB_d.all.Frequence := Frequence;
            AB_d.all.Arbre_Gauche := null;
            AB_d.all.Arbre_Droit := null;
            AB.all.Caractere := -2;
            AB.all.Frequence := Frequence + Frequence_Racine(AB_g);
            AB.Arbre_Gauche := AB_g;
            AB.Arbre_Droit := AB_d;
        else
            Frequence_Ancienne := La_Frequence(AB, Char);
            Enregistrer_char_present(AB, Char, Frequence, Frequence_Ancienne);
        end if;
    end Enregistrer_AB;

    procedure Supprimer_AB(AB : in out T_AB; Char : in T_Char) is
        procedure Supprimer(AB : in out T_AB; Char : in T_Char; Char_Abs : in out Boolean; Frequence : in Integer) is
            AB_tmp : T_AB;
        begin
            if AB = null then
                null;
            elsif AB.all.Arbre_Gauche /= null and then AB.all.Arbre_Gauche.all.Caractere = Char then
                AB_tmp := AB;
                AB := AB.all.Arbre_Droit;
                Free(AB_tmp.Arbre_Gauche);
                Free(AB_tmp);
                Char_Abs := False;
            elsif AB.all.Arbre_Droit /= null and then AB.all.Arbre_Droit.all.Caractere = Char then
                AB_tmp := AB;
                AB := AB.all.Arbre_Gauche;
                Free(AB_tmp.Arbre_Droit);
                Free(AB_tmp);
                Char_Abs := False;
            elsif AB.all.Caractere = Char then
                Vider_AB(AB);
                Char_Abs := False;
            elsif AB.all.Caractere /= -2 then
                null;
            else
                AB.all.Frequence := AB.all.Frequence - Frequence;
                Supprimer(AB.all.Arbre_Gauche, Char, Char_Abs, Frequence);
                Supprimer(AB.all.Arbre_Droit, Char, Char_Abs, Frequence);
            end if;
        end Supprimer;

        Char_Abs : Boolean := True;
        Frequence : Integer;
    begin
        Frequence := La_Frequence(AB, Char);
        Supprimer(AB, Char, Char_Abs, Frequence);
        if Char_Abs then
           raise Char_Absent_Exception;
        end if;
    end Supprimer_AB;

    function Char_Present(AB : in T_AB; Char : in T_Char) return Boolean is
        procedure P_Char_Present(AB : in T_AB; Char : in T_Char; Char_present : in out Boolean) is
        begin
            if AB = null then
                null;
            elsif AB.all.Caractere = Char then
                Char_present := True;
            else
                P_Char_Present(AB.all.Arbre_Gauche, Char, Char_present);
                P_Char_Present(AB.all.Arbre_Droit, Char, Char_present);
            end if;
        end P_Char_Present;

        Char_present : Boolean := False;
    begin
        P_Char_Present(AB, Char, Char_present);
        return Char_present;
    end Char_Present;

    function La_Frequence(AB : in T_AB; Char : in T_Char) return Integer is
        procedure La_Frequence(AB : in T_AB; Char : in T_Char; Char_Abs : in out Boolean; Frequence : in out Integer) is
        begin
            if AB = null then
                null;
            elsif AB.all.Caractere = Char then
                Char_Abs := False;
                Frequence := AB.all.Frequence;
            else
                La_Frequence(AB.all.Arbre_Gauche, Char, Char_Abs, Frequence);
                La_Frequence(AB.all.Arbre_Droit, Char, Char_Abs, Frequence);
            end if;
        end La_Frequence;

        Char_Abs : Boolean := True;
        Frequence : Integer := 0;
    begin
        La_Frequence(AB, Char, Char_Abs, Frequence);
        if Char_Abs then
            raise Char_Absent_Exception;
        else
            return Frequence;
        end if;
    end La_Frequence;

    procedure Vider_AB(AB : in out T_AB) is
    begin
        if AB /= null then
            Vider_AB(AB.all.Arbre_Gauche);
            Vider_AB(AB.all.Arbre_Droit);
            Free(AB);
        else
            null;
        end if;
    end Vider_AB;

    function Frequence_Racine(AB : T_AB) return Integer is
    begin
        return AB.all.Frequence;
    end Frequence_Racine;

    function Caractere_Racine(AB : T_AB) return T_Char is
    begin
        return AB.all.Caractere;
    end Caractere_Racine;

    procedure Copier_AB(AB : in T_AB; AB_Copie : in out T_AB) is
    begin
        if AB_Copie /= null then
            Vider_AB(AB_Copie);
        else
            null;
        end if;

        if AB /= null then
            AB_Copie := new T_Cellule;
            AB_Copie.all.Frequence := AB.all.Frequence;
            AB_Copie.all.Caractere := AB.all.Caractere;
            AB_Copie.all.Arbre_Gauche := null;
            AB_Copie.all.Arbre_Droit := null;
            Copier_AB(AB.all.Arbre_Gauche, AB_Copie.all.Arbre_Gauche);
            Copier_AB(AB.all.Arbre_Droit, AB_Copie.all.Arbre_Droit);
        else
            null;
        end if;
    end Copier_AB;

    procedure Fusionner_AB(AB_cree : out T_AB; AB_Gauche : in T_AB; AB_Droit : in T_AB) is
    begin
        Initialiser_AB(AB_cree);
        if AB_Droit /= null and then AB_Gauche /= null then
            AB_cree := new T_Cellule;
            AB_cree.all.Caractere := -2;
            AB_cree.all.Frequence := Frequence_Racine(AB_Gauche) + Frequence_Racine(AB_Droit);
            Copier_AB(AB_Gauche, AB_cree.Arbre_Gauche);
            Copier_AB(AB_Droit, AB_cree.Arbre_Droit);
        elsif AB_Gauche /= null then
            Copier_AB(AB_Gauche, AB_cree);
        elsif AB_Droit /= null then
            Copier_AB(AB_Droit, AB_cree);
        else
            null;
        end if;
    end Fusionner_AB;

    procedure Sous_Arbre_Gauche(AB_g : out T_AB; AB : in T_AB) is
    begin
        Copier_AB(AB.all.Arbre_Gauche, AB_g);
    end Sous_Arbre_Gauche;

    procedure Sous_Arbre_Droit(AB_d : out T_AB; AB : in T_AB) is
    begin
        Copier_AB(AB.all.Arbre_Droit, AB_d);
    end Sous_Arbre_Droit;

    procedure Afficher_AB(AB : in T_AB) is
        procedure Afficher_AB(AB : in T_AB; mem_parcours : in Unbounded_String) is
            mem : Unbounded_String := mem_parcours;
        begin
            if AB /= null then
                -- Afficher les fréquences et symboles à la bonne place
                if mem = "" then
                    Put('(');
                    Put(AB.all.Frequence, 1);
                    Put(')');
                else
                    -- Afficher les espaces et les barres
                    New_Line;
                    Put("  ");
                    while Length(mem) > 1 loop
                        if Element(mem, 1) = '1' then
                            Put("        ");
                        else
                            Put("|       ");
                        end if;
                        Delete(mem, 1, 1);
                    end loop;

                    if Element(mem, 1) = '1' then
                        Put("\--1--(");
                    else
                        Put("\--0--(");
                    end if;
                    Put(AB.all.Frequence, 1);
                    Put(')');
                end if;

                -- Afficher les caractères s'il y en a
                if AB.all.Caractere = -2 then
                    Afficher_AB(AB.all.Arbre_Gauche, mem_parcours & '0');
                    Afficher_AB(AB.all.Arbre_Droit, mem_parcours & '1');
                else
                    Put("'");
                    if AB.all.Caractere = -1 then
                        Put("\$");
                    elsif AB.all.Caractere = 10 then
                        Put("\n");
                    else
                        Put(Character'Val(AB.all.Caractere));
                    end if;
                    Put("'");
                end if;

            else
                null;
            end if;
        end Afficher_AB;
    begin
        -- Afficher l'arbre de Huffman comme la figure 20 p 11 de l'énoncé
        Afficher_AB(AB, To_Unbounded_String(""));
        New_Line;
    end Afficher_AB;

    function Code_AB(AB : in T_AB) return Unbounded_String is
    begin
        if AB = null then
            return To_Unbounded_String("");
        elsif AB.all.Caractere = -2 then
            return To_Unbounded_String("0") & Code_AB(AB.all.Arbre_Gauche) & Code_AB(AB.all.Arbre_Droit);
        else
            return To_Unbounded_String("1") & Code_AB(AB.all.Arbre_Gauche) & Code_AB(AB.all.Arbre_Droit);
        end if;
    end Code_AB;

    procedure Creer_AB_Huff(AB : out T_AB; Tab_Car : in T_TAB_CAR; Code_AB: in out Unbounded_String) is
        procedure Creer_AB_Huff(AB : in out T_AB; Tab_Car : in T_TAB_CAR; Code_AB: in out Unbounded_String; Indice : in out Integer) is
        begin
            if Code_AB /= To_Unbounded_String("") and then Indice <= Tab_Car.Taille then
                if Element(Code_AB, 1) = '0' then
                    Delete(Code_AB, 1, 1);
                    AB.Arbre_Gauche := new T_Cellule;
                    AB.Arbre_Droit := new T_Cellule;
                    AB.all.Frequence := 0;
                    AB.all.Caractere := -2;
                    Creer_AB_Huff(AB.all.Arbre_Gauche, Tab_Car, Code_AB, Indice);
                    Creer_AB_Huff(AB.all.Arbre_Droit, Tab_Car, Code_AB, Indice);
                else
                    Delete(Code_AB, 1, 1);
                    AB.all.Caractere := Tab_Car.Tableau(Indice);
                    AB.all.Frequence := 0;
                    Indice := Indice + 1;
                end if;
            end if;
        end Creer_AB_Huff;

        Indice : Integer := 1;

    begin
        AB := new T_Cellule;
        Creer_AB_Huff(AB, Tab_Car, Code_AB, Indice);
    end Creer_AB_Huff;

end AB;
