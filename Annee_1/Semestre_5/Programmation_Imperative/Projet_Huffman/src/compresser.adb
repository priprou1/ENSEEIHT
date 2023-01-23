with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with AB; use AB;
with TAB_HUFF; use TAB_HUFF;
with TAB_AB; use TAB_AB;
with OCTET; use OCTET;

-- Compresser un fichier Texte à l’aide de l’algorithme de Huffman.
procedure compresser is

    -- Retourne le maximum entre 2 entiers
    function max(i1 : in Integer; i2 : in Integer) return Integer is
    begin
        if i1 <= i2 then
            return i2;
        else
            return i1;
        end if;
    end max;

    -- Afficher l'usage
    procedure Afficher_Usage is
    begin
        New_Line;
        Put_Line ("Usage : " & Command_Name & " (Option) Fichier");
        Put_Line ("   Option  :  -b ou --bavard, non obligatoire, permet d'afficher les étapes de la compression");
        Put_Line ("   Fichier : Nom du fichier à compresser");
        New_Line;
    end Afficher_Usage;

    Nom_fichier_texte : Unbounded_String;
    Affichage : Boolean;
    Num_Arg_Nom : Integer;
    Texte_Lu : Ada.Streams.Stream_IO.File_Type;
    Texte_Compresse : Ada.Streams.Stream_IO.File_Type;
    S_Lu : Stream_Access;
    S_Compresse : Stream_Access;
    Tableau : T_TAB_AB;
    Arbre_B : T_AB;
    Tab_Huff : T_TAB_HUFF;
    Octet : T_Octet;
    Frequence : Integer;
    Char_Lu : T_Char;
    i_min_1 : Integer;
    i_min_2 : Integer;
    Indice : Integer;
    Taille : Integer;
    Code_Arbre : Unbounded_String;
    Code_Inserer : Unbounded_String;
    Taille_Tab : Integer;
    Command_error : Exception;
    Option_error : Exception;
    Fichier_Vide_Erreur : Exception;
begin
    if Argument_Count = 0 then
        -- Afficher un message à l'utilisateur.
        raise Command_error;
        -- Déterminer si l'option -b ou --bavard est mise.
    elsif Argument_Count >= 2 and then (Argument(1) = "-b" or else Argument(1) = "--bavard") then
        Affichage := True;
        Num_Arg_Nom := 2;
    elsif Argument_Count >= 2 and then Element(To_Unbounded_String(Argument(1)),1) = '-' then
        raise Option_error;
    elsif Element(To_Unbounded_String(Argument(1)),1) = '-' then
        raise Command_error;
    else
        Affichage := False;
        Num_Arg_Nom := 1;
    end if;

    -- Effectuer la compression.
    while Num_Arg_Nom <= Argument_Count loop
        begin
            Nom_fichier_texte := To_Unbounded_String(Argument(Num_Arg_Nom));
            -- Créer l'arbre de Huffman:
            Open(Texte_Lu, In_File, To_String(Nom_fichier_texte));
            S_Lu := Stream(Texte_Lu);
            -- Enregistrer les fréquences dans un tableau d'arbre en prenant compte le caractère \$.
            Initialiser(Tableau);

            if End_Of_File(Texte_Lu) then
                raise Fichier_Vide_Erreur;
            end if;

            while not End_Of_File(Texte_Lu) loop
                Octet := T_Octet'Input(S_Lu);
                Char_Lu := Character'Pos(Character'Val(Octet));
                if Caractere_Present(Tableau, Char_Lu) then
                    Frequence := Frequence_Character(Tableau, Char_Lu) + 1;
                    Enregistrer(Tableau, Char_Lu, Frequence);
                else
                    Enregistrer(Tableau, Char_Lu, 1);
                end if;
            end loop;
            Enregistrer(Tableau, -1,0); -- Enregistrement de '\$'.

            Close(Texte_Lu);

            -- Regrouper les arbres du tableau pour obtenir un arbre de Huffman.
            Taille_Tab := TAB_AB.Taille(Tableau);
            while Taille_Tab > 1 loop
                -- Trouver les deux arbres dont la valeur de fréquence de la racine est la plus faible.
                i_min_1 := 1;
                i_min_2 := 2;
                for i in 3..Taille_Tab loop
                    if Frequence_Indice(Tableau, i) < max(Frequence_Indice(Tableau, i_min_1), Frequence_Indice(Tableau, i_min_2)) then
                        if Frequence_Indice(Tableau, i_min_1) > Frequence_Indice(Tableau, i_min_2) then
                            i_min_1 := i;
                        else
                            i_min_2 := i;
                        end if;
                    else
                        null;
                    end if;
                end loop;

                -- Regrouper ces 2 arbres.
                if Frequence_Indice(Tableau, i_min_1) < Frequence_Indice(Tableau, i_min_2) then
                    Regrouper(Tableau, i_min_1, i_min_2);
                else
                    Regrouper(Tableau, i_min_2, i_min_1);
                end if;
                Taille_Tab := TAB_AB.Taille(Tableau);

            end loop;

            Copier(Tableau, 1, Arbre_B);

            -- Creer la table de Huffman.
            Initialiser(Tab_Huff);
            Creer_Table(Tab_Huff,Arbre_B);

            if Affichage then
                Put("Compression du fichier " & To_String(Nom_fichier_texte) & ":");
                New_Line;
                Put("Arbre de Huffman :");
                New_Line;
                Afficher_AB(Arbre_B);
                New_Line;
                Put("Table de Huffman :");
                New_Line;
                Afficher_Table(Tab_Huff);
                New_Line;
            else
                null;
            end if;

            -- Créer le fichier compressé en format .hff.
            Create(Texte_Compresse, Out_File, To_String(Nom_fichier_texte) & ".hff");
            S_Compresse := Stream(Texte_Compresse);

            -- Insérer la liste des symboles.
            Indice := Table_Indice(Tab_Huff, -1);
            Taille := Taille_Table(Tab_Huff);
            T_Octet'Write(S_Compresse, T_Octet(Indice));
            for i in 1..Taille loop
                if i /= Indice then
                    T_Octet'Write(S_Compresse, T_Octet(Caractere_Indice(Tab_Huff, i)));
                else
                    null;
                end if;
            end loop;
            T_Octet'Write(S_Compresse, T_Octet(Caractere_Indice(Tab_Huff, Taille)));

            -- Insérer le code de l'arbre.
            Code_Arbre := Code_AB(Arbre_B);
            Code_Inserer := To_Unbounded_String("");
            for i in 1..Length(Code_Arbre) loop
                Code_Inserer := Code_Inserer & Element(Code_Arbre, i);
                if Length(Code_Inserer) = 8 then
                    T_Octet'Write(S_Compresse, To_Octet(Code_Inserer));
                    Code_Inserer := To_Unbounded_String("");
                else
                    null;
                end if;
            end loop;

            -- Insérer le texte codé.
            Open(Texte_Lu, In_File, To_String(Nom_fichier_texte));
            S_Lu := Stream(Texte_Lu);
            while not End_Of_File(Texte_Lu) loop
                Octet := T_Octet'Input(S_Lu);
                Char_Lu := Character'Pos(Character'Val(Octet));
                Code_Inserer := Code_Inserer & Table_Code(Tab_Huff, Char_Lu);
                if Length(Code_Inserer) = 8 then
                    T_Octet'Write(S_Compresse, To_Octet(Code_Inserer));
                    Code_Inserer := To_Unbounded_String("");
                elsif Length(Code_Inserer) > 8 then
                    T_Octet'Write(S_Compresse, To_Octet(Unbounded_Slice(Code_Inserer, 1, 8)));
                    Code_Inserer := Unbounded_Slice(Code_Inserer, 9, Length(Code_Inserer));
                else
                    null;
                end if;
            end loop;

            -- Insérer le caractère fin de texte
            Code_Inserer := Code_Inserer & Code_Indice(Tab_Huff, Indice);
            if Length(Code_Inserer) = 8 then
                T_Octet'Write(S_Compresse, To_Octet(Code_Inserer));
                Code_Inserer := To_Unbounded_String("");
            elsif Length(Code_Inserer) > 8 then
                T_Octet'Write(S_Compresse, To_Octet(Unbounded_Slice(Code_Inserer, 1, 8)));
                Code_Inserer := Unbounded_Slice(Code_Inserer, 9, Length(Code_Inserer));
            else
                null;
            end if;

            -- Insérer le dernier Octet
            if Code_Inserer /= To_Unbounded_String("") then
                for i in Length(Code_Inserer)..7 loop
                    Code_Inserer := Code_Inserer & "0";
                end loop;
                T_Octet'Write(S_Compresse, To_Octet(Code_Inserer));
            else
                null;
            end if;

            Close(Texte_Lu);

            Close(Texte_Compresse);

            -- Vider les arbres et tableaux d’arbres.
            Vider(Tableau);
            Vider_AB(Arbre_B);

            Put("Le fichier " & To_String(Nom_fichier_texte) & " a bien été compressé");
            New_Line;

        exception
            when Command_error => Afficher_Usage;
            when Ada.Text_IO.Name_Error => Put("Le fichier ");
                Put(To_String(Nom_fichier_texte));
                Put(" que vous voulez compresser n'existe pas");
                Afficher_Usage;
            when Fichier_Vide_Erreur => Put("Le fichier ");
                Put(To_String(Nom_fichier_texte));
                Put(" que vous voulez compresser est vide: il ne sert à rien de le compresser !");
                New_Line;
                Close(Texte_Lu);
        end;

        Num_Arg_Nom := Num_Arg_Nom  + 1;
    end loop;

exception
    when Command_error => Afficher_Usage;
    when Option_error => Put_Line("L'option " & Argument(1) & " que vous voulez utiliser n'existe pas");
        Afficher_Usage;
end compresser;
