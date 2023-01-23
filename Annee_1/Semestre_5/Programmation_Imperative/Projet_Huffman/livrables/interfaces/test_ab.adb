with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AB_Exceptions; use AB_Exceptions;
with AB; use AB;

procedure Test_AB is

    Taille_AB : constant Integer := 9;
    Frequences_AB : constant array(1..Taille_AB) of Integer := (4, 9, 15, 2, 4, 5, 6, 11, 13);
    Caracteres_AB : constant array(1..Taille_AB) of Character := ('a', Character'Val(3), Character'Val(10), 'o', 'p', 'm' ,'d', 'g', 'h'); -- ici Character'Val(3) correspond à \$
    Inconnu : constant T_Char := -4;-- Car ici il n'est pas dans les caractères donnés
    Taille_Huff : constant Integer := 5;
    Code_Huff : Unbounded_String := To_Unbounded_String ("000011111");
    Caracteres_Huff : constant array(1..Taille_Huff) of Character := ('m', 'x', 'l', ' ', 't');

    -- Initialiser un arbre binaire avec les données ci-dessus
    procedure Construire_AB (AB : out T_AB; Bavard : Boolean := False) is
        Char : T_Char;
    begin
        Initialiser_AB (AB);
        pragma Assert (Est_vide_AB(AB));
        pragma Assert (Taille (AB) = 0);

        for I in 1..Taille_AB loop
            if Caracteres_AB(I) /= Character'Val(3) then
                Char := Character'Pos(Caracteres_AB(I));
            else
                Char := -1;
            end if;
            Enregistrer_AB (AB, Char, Frequences_AB(I));

            if Bavard then
                if Char = -1 then
                    Put_Line ("Après ajout du caratère \$");
                elsif Char = 10 then
                    Put_Line ("Après ajout du caratère \n");
                else
                    Put_Line ("Après ajout du caratère " & Character'Val(Char));
                end if;
                Afficher_AB (AB);
                New_Line;
            else
                null;
            end if;

            pragma Assert (not Est_Vide_AB (AB));
            pragma Assert (Taille (AB) = I);

            for J in 1..I loop
                if J = 2 then
                    pragma Assert (La_Frequence (AB, -1) = Frequences_AB (J));
                else
                    pragma Assert (La_Frequence (AB, Character'Pos(Caracteres_AB (J))) = Frequences_AB (J));
                end if;
            end loop;

            for J in I+1..Taille_AB loop
                if J = 2 then
                    pragma Assert (not Char_Present (AB, -1));
                else
                    pragma Assert (not Char_Present (AB, Character'Pos(Caracteres_AB(J))));
                end if;
            end loop;
        end loop;
    end Construire_AB;


    procedure Tester_Construire_AB is
        AB : T_AB;
    begin
        Construire_AB (AB, True);
        Vider_AB (AB);
    end Tester_Construire_AB;


    -- Tester suppression en commençant par les derniers éléments ajoutés
    procedure Tester_Supprimer_Inverse is
        AB : T_AB;
    begin
        Put_Line ("=== Tester_Supprimer_Inverse..."); New_Line;

        Construire_AB (AB);

        for I in reverse 1..Taille_AB loop
            if I = 2 then
                Supprimer_AB (AB, -1);
            else
                Supprimer_AB (AB, Character'Pos(Caracteres_AB (I)));
            end if;
            Put_Line ("Après suppression de " & Caracteres_AB (I) & " :");
            Afficher_AB (AB); New_Line;

            for J in 1..I-1 loop
                if J = 2 then
                    pragma Assert (Char_Present(AB, -1));
                    pragma Assert (La_Frequence(AB, -1) = Frequences_AB (J));
                else
                    pragma Assert (Char_Present(AB, Character'Pos(Caracteres_AB (J))));
                    pragma Assert (La_Frequence (AB, Character'Pos(Caracteres_AB (J))) = Frequences_AB (J));
                end if;
            end loop;

            for J in I..Taille_AB loop
                if J = 2 then
                    pragma Assert (not Char_Present (AB, -1));
                else
                    pragma Assert (not Char_Present (AB, Character'Pos(Caracteres_AB (J))));
                    end if;
            end loop;
        end loop;

        Vider_AB (AB);
    end Tester_Supprimer_Inverse;


    -- Tester suppression en commençant les les premiers éléments ajoutés
	procedure Tester_Supprimer is
		AB : T_AB;
	begin
		Put_Line ("=== Tester_Supprimer..."); New_Line;

		Construire_AB (AB);

        for I in 1..Taille_AB loop
            if I = 2 then
                Put_Line ("Suppression de /$ :");
                Supprimer_AB (AB, -1);
            else
                Put_Line ("Suppression de " & Caracteres_AB (I) & " :");
                Supprimer_AB (AB, Character'Pos(Caracteres_AB (I)));
            end if;

			Afficher_AB (AB); New_Line;

            for J in 1..I loop
                if J = 2 then
                    pragma Assert (not Char_Present (AB, -1));
                else
                    pragma Assert (not Char_Present (AB, Character'Pos(Caracteres_AB (J))));
                end if;
			end loop;

            for J in I+1..Taille_AB loop
                if J = 2 then
                    pragma Assert (Char_Present (AB, -1));
                    pragma Assert (La_Frequence (AB, -1) = Frequences_AB (J));
                else
                    pragma Assert (Char_Present (AB, Character'Pos(Caracteres_AB (J))));
                    pragma Assert (La_Frequence (AB, Character'Pos(Caracteres_AB (J))) = Frequences_AB (J));
                end if;
			end loop;
		end loop;

		Vider_AB (AB);
    end Tester_Supprimer;


    procedure Tester_Supprimer_Un_Element is
        -- Tester supprimer sur un élément, celui à Indice dans Caracteres_AB.
        procedure Tester_Supprimer_Un_Element (Indice: in Integer) is
            AB : T_AB;
        begin
            Construire_AB (AB);

            if Indice = 2 then
                Put_Line ("Suppression de /$ :");
                Supprimer_AB (AB, -1);
            else
                Put_Line ("Suppression de " & Caracteres_AB (Indice) & " :");
                Supprimer_AB (AB, Character'Pos(Caracteres_AB (Indice)));
            end if;

            Afficher_AB (AB); New_Line;

            for J in 1..Taille_AB loop
                if J = Indice and then J/= 2 then
                    pragma Assert (not Char_Present (AB, Character'Pos(Caracteres_AB (J))));
                elsif J = Indice then
                    pragma Assert (not Char_Present (AB, -1));
                elsif J/= 2 then
                    pragma Assert (Char_Present (AB, Character'Pos(Caracteres_AB (J))));
                else
                    pragma Assert (Char_Present (AB, -1));
                end if;
            end loop;

            Vider_AB (AB);
        end Tester_Supprimer_Un_Element;

    begin
        Put_Line ("=== Tester_Supprimer_Un_Element..."); New_Line;

        for I in 1..Taille_AB loop
            Tester_Supprimer_Un_Element (I);
        end loop;
    end Tester_Supprimer_Un_Element;


    procedure Tester_Remplacer_Un_Element is
		-- Tester enregistrer sur un élément présent, celui à Indice dans Caracteres_AB.
		procedure Tester_Remplacer_Un_Element (Indice: in Integer; Nouveau: in Integer) is
			AB : T_AB;
		begin
			Construire_AB (AB);
            if Indice = 2 then
                Put_Line ("Remplacement de la fréquence de /$ par " & Integer'Image(Nouveau) & " :");
                Enregistrer_AB (AB, -1, Nouveau);
            else
                Put_Line ("Remplacement de la fréquence de " & Caracteres_AB (Indice)
					& " par " & Integer'Image(Nouveau) & " :");
                Enregistrer_AB (AB, Character'Pos(Caracteres_AB (Indice)), Nouveau);
            end if;

			Afficher_AB (AB); New_Line;

            for J in 1..Taille_AB loop
                if J /= 2 then
                    pragma Assert (Char_Present (AB, Character'Pos(Caracteres_AB (J))));
                    if J = Indice then
                        pragma Assert (La_Frequence (AB, Character'Pos(Caracteres_AB (J))) = Nouveau);
                    else
                        pragma Assert (La_Frequence (AB, Character'Pos(Caracteres_AB (J))) = Frequences_AB (J));
                    end if;
                else
                    pragma Assert (Char_Present (AB, -1));
                    if J = Indice then
                        pragma Assert (La_Frequence (AB, -1) = Nouveau);
                    else
                        pragma Assert (La_Frequence (AB, -1) = Frequences_AB (J));
                    end if;
                end if;
			end loop;

			Vider_AB (AB);
        end Tester_Remplacer_Un_Element;

	begin
		Put_Line ("=== Tester_Remplacer_Un_Element..."); New_Line;

		for I in 1..Taille_AB loop
			Tester_Remplacer_Un_Element (I, 0);
		end loop;
    end Tester_Remplacer_Un_Element;


    procedure Tester_Supprimer_Erreur is
		AB : T_AB;
	begin
		begin
			Put_Line ("=== Tester_Supprimer_Erreur..."); New_Line;

			Construire_AB (AB);
			Supprimer_AB (AB, Inconnu);

		exception
			when Char_Absent_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Vider_AB (AB);
    end Tester_Supprimer_Erreur;


    procedure Tester_La_Frequence_Erreur is
		AB : T_AB;
		Inutile: Integer;
	begin
		begin
			Put_Line ("=== Tester_La_Frequence_Erreur..."); New_Line;

			Construire_AB (AB);
			Inutile := La_Frequence (AB, Inconnu);

		exception
			when Char_Absent_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Vider_AB (AB);
    end Tester_La_Frequence_Erreur;


    procedure Tester_Frequence_Racine is
        AB : T_AB;
        Frequence : Integer;
    begin
        Put_Line ("=== Tester_Frequence_Racine..."); New_Line;

        Construire_AB (AB);
        Frequence := 0;

        for I in 1..Taille_AB loop
            Frequence := Frequence + Frequences_AB (I);
        end loop;

        pragma Assert (Frequence = Frequence_Racine (AB));

        Vider_AB(AB);

        Initialiser_AB (AB);

        Enregistrer_AB (AB, Character'Pos('A'), 10);

        pragma Assert (Frequence_Racine (AB) = 10);

        Vider_AB (AB);
    end Tester_Frequence_Racine;


    procedure Tester_Caractere_Racine is
        AB : T_AB;
    begin
        Put_Line ("=== Tester_Caractere_Racine..."); New_Line;

        Construire_AB(AB);
        pragma Assert (Caractere_Racine (AB) = -2);

        Vider_AB (AB);

        Initialiser_AB (AB);

        Enregistrer_AB (AB, Character'Pos('A'), 10);

        pragma Assert (Caractere_Racine (AB) = Character'Pos('A'));

        Vider_AB (AB);
    end Tester_Caractere_Racine;


    procedure Tester_Copier_AB is
        AB : T_AB;
        AB_Copie : T_AB;
    begin
        Put_Line ("=== Tester_Copier_AB..."); New_Line;

        Construire_AB(AB);
        Copier_AB(AB,AB_Copie);
        pragma Assert (Est_Egal(AB, AB_Copie));

        Vider_AB (AB);
        Vider_AB (AB_Copie);
    end Tester_Copier_AB;


    procedure Tester_Fusionner is
        AB_cree : T_AB;
        AB_g : T_AB;
        AB_d : T_AB;
        Frequence : Integer := 0;
    begin
        Put_Line ("=== Tester_Fusionner..."); New_Line;

        Construire_AB (Ab_g);

        for I in 1..Taille_AB loop
            Frequence := Frequence + Frequences_AB (I);
        end loop;

        Initialiser_AB (AB_d);

        Enregistrer_AB (AB_d, Character'Pos('A'), 10);
        Frequence := Frequence + 10;

        Enregistrer_AB (AB_d, Character'Pos('L'), 15);
        Frequence := Frequence + 15;

        Enregistrer_AB (AB_d, Character'Pos('M'), 12);
        Frequence := Frequence + 12;

        Fusionner_AB (AB_cree, AB_g, AB_d);

        pragma Assert (Taille (AB_cree) = Taille (AB_g) + Taille (AB_d));
        pragma Assert (Frequence_Racine (AB_cree) = Frequence);
        pragma Assert (Caractere_Racine (AB_cree) = -2);

        Vider_AB (AB_cree);
        Vider_AB (AB_g);
        Vider_AB (AB_d);
    end Tester_Fusionner;


    procedure Tester_Sous_Arbre is
        AB : T_AB;
        AB_g : T_AB;
        AB_d : T_AB;
        AB_Cree : T_AB;
    begin
        Put_Line ("=== Tester_Sous_Arbre..."); New_Line;

        Construire_AB (AB);

        Sous_Arbre_Gauche (AB_g, AB);
        Sous_Arbre_Droit (AB_d, AB);

        Fusionner_AB (AB_Cree, AB_g, AB_d);
        pragma Assert (Est_Egal(AB_Cree, AB));

        Vider_AB (AB);
        Vider_AB (AB_Cree);
        Vider_AB (AB_g);
        Vider_AB (AB_d);
    end Tester_Sous_Arbre;


    -- Construire un abre de huffman pour Test_Code_AB
    procedure Construire_Huff_code(AB_9 : out T_AB) is
        AB_1 : T_AB;
        AB_2 : T_AB;
        AB_3 : T_AB;
        AB_4 : T_AB;
        AB_5 : T_AB;
        AB_6 : T_AB;
        AB_7 : T_AB;
        AB_8 : T_AB;
    begin
        Initialiser_AB(AB_1);
        Initialiser_AB(AB_2);
        Initialiser_AB(AB_4);
        Initialiser_AB(AB_6);
        Initialiser_AB(AB_8);

        Enregistrer_AB(AB_1,Character'Pos('m'),1);
        Enregistrer_AB(AB_2,Character'Pos('x'),2);
        Fusionner_AB(AB_3, AB_1, AB_2);
        Enregistrer_AB(AB_4,Character'Pos('l'),4);
        Fusionner_AB(AB_5, AB_3, AB_4);
        Enregistrer_AB(AB_6,Character'Pos(' '),4);
        Fusionner_AB(AB_7, AB_5, AB_6);
        Enregistrer_AB(AB_8,Character'Pos('t'),4);
        Fusionner_AB(AB_9, AB_7, AB_8);
        Vider_AB(AB_1);
        Vider_AB(AB_2);
        Vider_AB(AB_3);
        Vider_AB(AB_4);
        Vider_AB(AB_5);
        Vider_AB(AB_6);
        Vider_AB(AB_7);
        Vider_AB(AB_8);
    end Construire_Huff_code;


    -- Construire un abre de huffman pour Test_Creer_AB_Huff
    procedure Construire_Huff(AB_9 : out T_AB) is
        AB_1 : T_AB;
        AB_2 : T_AB;
        AB_3 : T_AB;
        AB_4 : T_AB;
        AB_5 : T_AB;
        AB_6 : T_AB;
        AB_7 : T_AB;
        AB_8 : T_AB;
    begin
        Initialiser_AB(AB_1);
        Initialiser_AB(AB_2);
        Initialiser_AB(AB_4);
        Initialiser_AB(AB_6);
        Initialiser_AB(AB_8);

        Enregistrer_AB(AB_1,Character'Pos('m'),0);
        Enregistrer_AB(AB_2,Character'Pos('x'),0);
        Fusionner_AB(AB_3, AB_1, AB_2);
        Enregistrer_AB(AB_4,Character'Pos('l'),0);
        Fusionner_AB(AB_5, AB_3, AB_4);
        Enregistrer_AB(AB_6,Character'Pos(' '),0);
        Fusionner_AB(AB_7, AB_5, AB_6);
        Enregistrer_AB(AB_8,Character'Pos('t'),0);
        Fusionner_AB(AB_9, AB_7, AB_8);
        Vider_AB(AB_1);
        Vider_AB(AB_2);
        Vider_AB(AB_3);
        Vider_AB(AB_4);
        Vider_AB(AB_5);
        Vider_AB(AB_6);
        Vider_AB(AB_7);
        Vider_AB(AB_8);
    end Construire_Huff;


    -- Construire une table de caractère pour l'utiliser dans Test_Creer_AB_Huff
    procedure Construire_Tab_Car(Tab_Car : out T_TAB_CAR) is
    begin
        Tab_Car.Taille := 0;
        for I in 1..Taille_Huff loop
            Tab_Car.Taille := Tab_Car.Taille + 1;
            Tab_Car.Tableau(I) := Character'Pos(Caracteres_Huff(I));
        end loop;
    end Construire_Tab_Car;


    procedure Tester_Code_AB is
        AB_Huff : T_AB;
        Code : Unbounded_String;
    begin
        Put_Line ("=== Tester_Code_AB..."); New_Line;
        Construire_Huff_code(AB_Huff);
        Code := Code_AB (AB_Huff);
        pragma Assert (Code = Code_Huff);
        Vider_AB (AB_Huff);
    end Tester_Code_AB;


    procedure Tester_Creer_AB_Huff is
        AB_Huff : T_AB;
        AB_Cree : T_AB;
        Tab_Car : T_TAB_CAR;
    begin
        Put_Line ("=== Tester_Creer_AB_Huff..."); New_Line;
        Construire_Huff(AB_Huff);
        Construire_Tab_Car(Tab_Car);
        Creer_AB_Huff(AB_Cree, Tab_Car, Code_Huff);
        Afficher_AB(AB_Cree);
        Put_Line("AB_Huff");
        Afficher_AB(AB_Huff);
        pragma Assert (Est_Egal(AB_Huff, AB_Cree));
        Vider_AB (AB_Huff);
        Vider_AB (AB_Cree);
    end Tester_Creer_AB_Huff;

begin
    Tester_Construire_AB;
    Tester_Supprimer_Inverse;
    Tester_Supprimer;
    Tester_Supprimer_Un_Element;
    Tester_Remplacer_Un_Element;
    Tester_Supprimer_Erreur;
    Tester_La_Frequence_Erreur;
    Tester_Frequence_Racine;
    Tester_Caractere_Racine;
    Tester_Copier_AB;
    Tester_Fusionner;
    Tester_Sous_Arbre;
    Tester_Code_AB;
    Tester_Creer_AB_Huff;
    New_Line;
    Put_Line ("Fin des tests : OK.");
end Test_AB;
