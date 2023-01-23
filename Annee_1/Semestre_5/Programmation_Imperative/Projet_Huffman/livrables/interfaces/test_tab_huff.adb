with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
--with Ada.Text_IO.Unbounded_IO; use  Ada.Text_IO.Unbounded_IO;
with TAB_HUFF; use TAB_HUFF;
with AB; use AB;

procedure Test_TAB_HUFF is

    Taille : constant Integer := 11;
    Caractere_Tab : constant array (1..Taille) of Character := ('m','x',Character'Val(10),'l',' ','t','d',Character'Val(3),':','p','e');--0?
    Code_Tab : constant array (1..Taille) of Unbounded_String := (To_Unbounded_String("0000000000"),To_Unbounded_String("0000000001"),To_Unbounded_String("000000001"),To_Unbounded_String("00000001"),To_Unbounded_String("0000001"),To_Unbounded_String("000001"),To_Unbounded_String("00001"),To_Unbounded_String("0001"),To_Unbounded_String("001"),To_Unbounded_String("01"),To_Unbounded_String("1"));

    procedure Construire_Table_Exemple(tab: in out T_TAB_HUFF; Bavard : Boolean := False) is
        ab_huff : T_AB;
    begin
        Initialiser(tab);
        pragma Assert (Est_vide(tab));

        Initialiser_AB(ab_huff);

        Enregistrer_AB(ab_huff,Character'Pos('m'),4);
        Enregistrer_AB(ab_huff,Character'Pos('x'),4);
        Enregistrer_AB(ab_huff,Character'Pos(Character'Val(10)),2);
        Enregistrer_AB(ab_huff,Character'Pos('l'),2);
        Enregistrer_AB(ab_huff,Character'Pos(' '),5);
        Enregistrer_AB(ab_huff,Character'Pos('t'),5);
        Enregistrer_AB(ab_huff,Character'Pos('d'),1);
        Enregistrer_AB(ab_huff,Character'Pos(Character'Val(3)),0);
        Enregistrer_AB(ab_huff,Character'Pos(':'),1);
        Enregistrer_AB(ab_huff,Character'Pos('p'),3);
        Enregistrer_AB(ab_huff,Character'Pos('e'),15);

        Creer_Table(tab, ab_huff);
        pragma Assert (Taille_table(tab) = Taille);

        if Bavard then
            Put_Line ("Affichage de la table de Huffman :");
            Afficher_Table (tab);
            New_Line;
        else
            null;
        end if;
        Vider_AB(ab_huff);
    end Construire_Table_Exemple;


    procedure Test_Construire_Table_Exemple is
        tab_huff : T_TAB_HUFF;
    begin
        Construire_Table_Exemple(tab_huff, True);
    end Test_Construire_Table_Exemple;


    procedure Test_Code_Indice is
        tab_huff : T_TAB_HUFF;
    begin
        Put_Line ("=== Tester_Code_Indice...");

        Construire_Table_Exemple(tab_huff);

        for i in 1..Taille_table(tab_huff) loop
            pragma Assert (Code_Indice(tab_huff, i) = Code_Tab(i));
        end loop;
    end Test_Code_Indice;


    procedure Test_Caractere_Indice is
        tab_huff : T_TAB_HUFF;
    begin
        Put_Line ("=== Tester_Caractere_Indice...");

        Construire_Table_Exemple(tab_huff);

        for i in 1..Taille_table(tab_huff) loop
            pragma Assert (Caractere_Indice(tab_huff, i) = Character'Pos(Caractere_Tab(i)));
        end loop;
    end Test_Caractere_Indice;


    procedure Test_Table_Code is
        tab_huff : T_TAB_HUFF;
    begin
        Put_Line ("=== Tester_Table_Code...");

        Construire_Table_Exemple(tab_huff);

        for i in 1..Taille_table(tab_huff) loop
            pragma Assert (Table_Code(tab_huff, Character'Pos(Caractere_Tab(i))) = Code_Tab(i));
        end loop;
    end Test_Table_Code;


    procedure Test_Table_Indice is
        tab_huff : T_TAB_HUFF;
    begin
        Put_Line ("=== Tester_Table_Indice...");

        Construire_Table_Exemple(tab_huff);

        for i in 1..Taille_table(tab_huff) loop
            pragma Assert (Table_Indice(tab_huff,Character'Pos(Caractere_Tab(i))) = i);
        end loop;
    end Test_Table_Indice;

begin
    Test_Construire_Table_Exemple;
    Test_Code_Indice;
    Test_Caractere_Indice;
    Test_Table_Code;
    Test_Table_Indice;
    New_Line;
    Put_Line ("Fin des tests : OK.");
end Test_TAB_HUFF;
