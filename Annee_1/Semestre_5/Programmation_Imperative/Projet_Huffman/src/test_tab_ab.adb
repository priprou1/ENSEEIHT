with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with AB; use AB;
with TAB_AB; use TAB_AB;

procedure Test_TAB_AB is

    taille_AB_1 : constant Integer := 9;
    taille_AB_2 : constant Integer := 6;
    taille_AB_3 : constant Integer := 4;

    Frequences_AB_1 : constant array(1..taille_AB_1) of Integer := (4, 9, 15, 2, 4, 5, 6, 11, 13);
    Frequences_AB_2 : constant array(1..taille_AB_2) of Integer := (9, 1, 4, 7, 2, 12);
    Frequences_AB_3 : constant array(1..taille_AB_3) of Integer := (14, 2, 6, 5);

    Caracteres_AB_1 : constant array(1..taille_AB_1) of Character := ('a', 'c', 't', 'o', 'p', 'm' ,'d', 'g', 'h');
    Caracteres_AB_2 : constant array(1..taille_AB_2) of Character := ('j', 'k', 'f', 'u', 'e', 's');
    Caracteres_AB_3 : constant array(1..taille_AB_3) of Character := ('q', 'v', 'b', 'n');

    -- Initialiser un tableau d'arbres binaires avec les données ci-dessus
    procedure Construire_TAB_AB (tab : out T_TAB_AB) is
        ab_1 : T_AB;
        ab_2 : T_AB;
        ab_3 : T_AB;
    begin
        Initialiser(tab);

        pragma Assert(Est_vide(tab));
        pragma Assert(Taille (tab) = 0);

        Initialiser_AB(ab_1);
        Initialiser_AB(ab_2);
        Initialiser_AB(ab_3);

        for i in 1..taille_AB_1 loop
            Enregistrer_AB(ab_1, Character'Pos(Caracteres_AB_1(i)), Frequences_AB_1(i));
        end loop;

        for i in 1..taille_AB_2 loop
            Enregistrer_AB(ab_2, Character'Pos(Caracteres_AB_2(i)), Frequences_AB_2(i));
        end loop;

        for i in 1..taille_AB_3 loop
            Enregistrer_AB(ab_3, Character'Pos(Caracteres_AB_3(i)), Frequences_AB_3(i));
        end loop;

        Ajouter(tab, ab_1);
        pragma Assert (Taille(tab) = 1);
        Ajouter(tab, ab_2);
        pragma Assert (Taille(tab) = 2);
        Ajouter(tab, ab_3);
        pragma Assert (Taille(tab) = 3);

        Vider_AB (ab_1);
        Vider_AB (ab_2);
        Vider_AB (ab_3);
    end Construire_TAB_AB;


    procedure Tester_Caractere_Present is
        tab : T_TAB_AB;
    begin
        Put_Line ("=== Tester_Caractere_Present...");
        Construire_TAB_AB(tab);

        for i in 1..taille_AB_1 loop
            pragma Assert(Caractere_Present(tab,Character'Pos(Caracteres_AB_1(i))));
        end loop;

        for i in 1..taille_AB_2 loop
            pragma Assert(Caractere_Present(tab,Character'Pos(Caracteres_AB_2(i))));
        end loop;

        for i in 1..taille_AB_3 loop
            pragma Assert(Caractere_Present(tab,Character'Pos(Caracteres_AB_3(i))));
        end loop;

        Vider(tab);
    end Tester_Caractere_Present;


    procedure Tester_Indice_Character is
        tab : T_TAB_AB;
    begin

        Put_Line ("=== Tester_Indice_Character...");
        Construire_TAB_AB(tab);

        for i in 1..taille_AB_1 loop
            pragma Assert(Indice_Character(tab,Character'Pos(Caracteres_AB_1(i))) = 1);
        end loop;

        for i in 1..taille_AB_2 loop
            pragma Assert(Indice_Character(tab,Character'Pos(Caracteres_AB_2(i))) = 2);
        end loop;

        for i in 1..taille_AB_3 loop
            pragma Assert(Indice_Character(tab,Character'Pos(Caracteres_AB_3(i))) = 3);
        end loop;

        Vider(tab);
    end Tester_Indice_Character;


    procedure Tester_Frequence_Character is
        tab : T_TAB_AB;
    begin

        Put_Line ("=== Tester_Frequence_Character...");
        Construire_TAB_AB(tab);

        for i in 1..taille_AB_1 loop
            pragma Assert(Frequence_Character(tab,Character'Pos(Caracteres_AB_1(i))) = Frequences_AB_1(i));
        end loop;

        for i in 1..taille_AB_2 loop
            pragma Assert(Frequence_Character(tab,Character'Pos(Caracteres_AB_2(i))) = Frequences_AB_2(i));
        end loop;

        for i in 1..taille_AB_3 loop
            pragma Assert(Frequence_Character(tab,Character'Pos(Caracteres_AB_3(i))) = Frequences_AB_3(i));
        end loop;

        Vider(tab);
    end Tester_Frequence_Character;


    procedure Tester_Frequence_Indice is
        tab : T_TAB_AB;
        somme1 : Integer := 0;
        somme2 : Integer := 0;
        somme3 : Integer := 0;
    begin
        Put_Line ("=== Tester_Frequence_Indice...");
        Construire_TAB_AB(tab);

        for i in 1..taille_AB_1 loop
            somme1 := somme1 + Frequences_AB_1(i);
        end loop;

        for i in 1..taille_AB_2 loop
            somme2 := somme2 + Frequences_AB_2(i);
        end loop;

        for i in 1..taille_AB_3 loop
            somme3 := somme3 + Frequences_AB_3(i);
        end loop;

        pragma Assert(Frequence_Indice(tab,1) = somme1);
        pragma Assert(Frequence_Indice(tab,2) = somme2);
        pragma Assert(Frequence_Indice(tab,3) = somme3);

        Vider(tab);
    end Tester_Frequence_Indice;


    procedure Tester_Supprimer is
        tab : T_TAB_AB;
    begin
        Put_Line ("=== Tester_Supprimer...");
        Construire_TAB_AB(tab);

        Supprimer(Tab, 1);

        pragma Assert(Taille(Tab) = 2);
        pragma Assert(Caractere_Present(Tab, Character'Pos('j')));
        pragma Assert(Caractere_Present(Tab, Character'Pos('q')));

        Supprimer(Tab, 2);

        pragma Assert(Taille(Tab) = 1);
        pragma Assert(Caractere_Present(Tab, Character'Pos('q')));

        Supprimer(Tab, 1);

        pragma Assert(Est_vide(Tab));

        Vider(tab);
    end Tester_Supprimer;


    procedure Tester_Enregistrer is
        tab : T_TAB_AB;
    begin
        Put_Line ("=== Tester_Enregistrer...");
        Construire_TAB_AB(tab);

        Enregistrer(Tab, Character'Pos('x'), 7);
        pragma Assert(Caractere_Present(Tab,Character'Pos('x')));
        pragma Assert(Frequence_Character(Tab, Character'Pos('x')) = 7);
        pragma Assert(Taille(Tab) = 4);

        Enregistrer(Tab, Character'Pos('x'), 8);
        pragma Assert(Caractere_Present(Tab,Character'Pos('x')));
        pragma Assert(Frequence_Character(Tab, Character'Pos('x')) = 8);
        pragma Assert(Taille(Tab) = 4);

        Enregistrer(Tab, Character'Pos('y'), 8);
        pragma Assert(Caractere_Present(Tab,Character'Pos('y')));
        pragma Assert(Frequence_Character(Tab, Character'Pos('y')) = 8);
        pragma Assert(Taille(Tab) = 5);

        Enregistrer(Tab, Character'Pos('z'), 9);
        pragma Assert(Caractere_Present(Tab,Character'Pos('z')));
        pragma Assert(Frequence_Character(Tab, Character'Pos('z')) = 9);
        pragma Assert(Taille(Tab) = 6);

        Vider(tab);
    end Tester_Enregistrer;


    procedure Tester_Ajouter is
        tab : T_TAB_AB;
        ab: T_AB;
    begin
        Put_Line ("=== Tester_Ajouter...");
        Construire_TAB_AB(tab);

        Initialiser_AB(ab);
        Enregistrer_AB(ab, Character'Pos('x'), 7);
        Enregistrer_AB(ab, Character'Pos('y'), 8);
        Enregistrer_AB(ab, Character'Pos('z'), 9);

        Ajouter(Tab, ab);

        pragma Assert(Taille(Tab) = 4);

        pragma Assert(Caractere_Present(Tab,Character'Pos('x')));
        pragma Assert(Frequence_Character(Tab, Character'Pos('x') )= 7);

        pragma Assert(Caractere_Present(Tab,Character'Pos('y')));
        pragma Assert(Frequence_Character(Tab, Character'Pos('y')) = 8);

        pragma Assert(Caractere_Present(Tab, Character'Pos('z')));
        pragma Assert(Frequence_Character(Tab, Character'Pos('z')) = 9);

        Vider(tab);
        Vider_AB(ab);
    end Tester_Ajouter;


    procedure Tester_Regrouper is
        tab : T_TAB_AB;
    begin
        Put_Line ("=== Tester_Regrouper...");
        Construire_TAB_AB(tab);

        Regrouper(Tab,1 ,2);

        pragma Assert(Taille(Tab) = 2);

        for i in 1..taille_AB_1 loop
            pragma Assert(Frequence_Character(tab,Character'Pos(Caracteres_AB_1(i))) = Frequences_AB_1(i));
            pragma Assert(Caractere_Present(tab,Character'Pos(Caracteres_AB_1(i))));
        end loop;

        for i in 1..taille_AB_2 loop
            pragma Assert(Frequence_Character(tab,Character'Pos(Caracteres_AB_2(i))) = Frequences_AB_2(i));
            pragma Assert(Caractere_Present(tab,Character'Pos(Caracteres_AB_2(i))));
        end loop;

        for i in 1..taille_AB_3 loop
            pragma Assert(Frequence_Character(tab,Character'Pos(Caracteres_AB_3(i))) = Frequences_AB_3(i));
            pragma Assert(Caractere_Present(tab,Character'Pos(Caracteres_AB_3(i))));
        end loop;

        Vider(tab);
    end Tester_Regrouper;


    procedure Tester_Copier is
        tab : T_TAB_AB;
        ab :T_AB;
    begin
        Put_Line ("=== Tester_Copier...");
        Construire_TAB_AB(tab);

        Copier(Tab,1,ab);

        pragma Assert(Taille(Tab) = 3);

        for i in 1..taille_AB_1 loop
            pragma Assert(Char_Present(ab, Character'Pos(Caracteres_AB_1(i))));
            pragma Assert(La_Frequence(ab, Character'Pos(Caracteres_AB_1(i))) = Frequences_AB_1(i));
        end loop;

        Vider(tab);
        Vider_AB(ab);
    end Tester_Copier;

begin
    Tester_Caractere_Present;
    Tester_Indice_Character;
    Tester_Frequence_Character;
    Tester_Frequence_Indice;
    Tester_Supprimer;
    Tester_Enregistrer;
    Tester_Ajouter;
    Tester_Regrouper;
    Tester_Copier;
    Put("Fin des tests : OK.");
end Test_TAB_AB;
