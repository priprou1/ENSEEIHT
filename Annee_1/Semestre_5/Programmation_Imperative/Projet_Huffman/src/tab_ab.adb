package body TAB_AB is

    procedure Initialiser(Tab: out T_TAB_AB) is
    begin
        Tab.Taille := 0;
        for i in 1..CAPACITE loop
            Initialiser_AB(Tab.Tableau(i));
        end loop;
    end Initialiser;


    function Est_Vide(Tab: in T_TAB_AB) return Boolean is
        b : Boolean := True;
    begin
        for i in 1..CAPACITE loop
            if not(Est_vide_AB(Tab.Tableau(i))) then
                b := False;
            end if;
        end loop;
        return b;
    end Est_Vide;


    function Caractere_Present(Tab: in T_TAB_AB; Char: in T_Char) return Boolean is
        b : Boolean := False;
    begin
        for i in 1..CAPACITE loop
            if Char_Present(Tab.Tableau(i), Char) then
                b := True;
            end if;
        end loop;
        return b;
    end Caractere_Present;


    function Indice_Character(Tab: in T_TAB_AB; Char: in T_Char) return Integer is
        Indice : Integer;
    begin
        for i in 1..CAPACITE loop
            if Char_Present(Tab.Tableau(i), Char) then
                Indice := i;
            end if;
        end loop;
        return Indice;
    end Indice_Character;


    function Frequence_Character(Tab: in T_TAB_AB; Char: in T_Char) return Integer is
        frequence : Integer := 0;
        trouve : Boolean := False;
        i : Integer := 1;
    begin
        while not(trouve) and (i<=CAPACITE) loop
            if Char_Present(Tab.Tableau(i), Char) then
                trouve := True;
                frequence := La_Frequence(Tab.Tableau(i), Char);
            end if;
            i := i + 1;
        end loop;
        return frequence;
    end Frequence_Character;


    function Frequence_Indice(Tab: in T_TAB_AB; Indice: in Integer) return Integer is
    begin
        return Frequence_Racine(Tab.Tableau(Indice));
    end Frequence_Indice;


    procedure Supprimer(Tab: in out T_TAB_AB; Position: in Integer) is
    begin
        if not(Position = Tab.Taille) then
            Copier_AB(Tab.Tableau(Tab.Taille), Tab.Tableau(Position));
        end if;
        Vider_AB(Tab.Tableau(Tab.Taille));
        Tab.Taille := Tab.Taille - 1;
    end Supprimer;


    procedure Enregistrer(Tab: in out T_TAB_AB; Char: in T_Char; Frequence : in Integer) is
        Indice : Integer;
    begin
        if not Caractere_Present(Tab, Char) then
            Tab.Taille := Tab.Taille + 1;
            Enregistrer_AB(Tab.Tableau(Tab.Taille), Char, Frequence);
        else
            Indice := Indice_Character(Tab, Char);
            Enregistrer_AB(Tab.Tableau(Indice), Char, Frequence);
        end if;
    end Enregistrer;


    procedure Ajouter(Tab: in out T_TAB_AB; AB: in T_AB) is
    begin
        Tab.Taille := Tab.Taille + 1;
        Copier_AB(AB, Tab.Tableau(Tab.Taille));
    end Ajouter;


    function Taille(Tab: in T_TAB_AB) return Integer is
    begin
        return Tab.Taille;
    end Taille;


    procedure Regrouper(Tab: in out T_TAB_AB; i1: in Integer; i2 : in Integer) is
    begin
        Tab.Taille := Tab.Taille + 1;
        Fusionner_AB(Tab.Tableau(Tab.Taille), Tab.Tableau(i1), Tab.Tableau(i2));
        Supprimer(Tab, i1);
        Supprimer(Tab, i2);
    end Regrouper;


    procedure Copier(Tab: in T_TAB_AB; Indice: in Integer; ab: in out T_AB) is
    begin
        Copier_AB(Tab.Tableau(Indice), ab);
    end Copier;


    procedure Vider(Tab: in out T_TAB_AB) is
    begin
        for i in 1..CAPACITE loop
            Vider_AB(Tab.Tableau(i));
        end loop;
    end Vider;

end TAB_AB;
