with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with AB; use AB;
with TAB_HUFF; use TAB_HUFF;
with OCTET; use OCTET;

-- Décompresser un fichier compressé à l’aide de l’algorithme de Huffman.
procedure decompresser is

    -- Afficher l'usage
    procedure Afficher_Usage is
    begin
        New_Line;
        Put_Line ("Usage : " & Command_Name & " (Option) Fichier");
        Put_Line ("   Option  :  -b ou --bavard, non obligatoire, permet d'afficher les étapes de la décompression");
        Put_Line ("   Fichier : Nom du fichier à décompresser, doit être au format .hff");
        New_Line;
    end Afficher_Usage;

    Nom_Texte_Compresse_US : Unbounded_String;
    Nom_Texte_Decompresse_US : Unbounded_String;
    Texte_Compresse :  Ada.Streams.Stream_IO.File_Type;
    Texte_Decompresse : Ada.Streams.Stream_IO.File_Type;
    Tab_Caract : T_TAB_CAR;
    S_Compresse : Stream_Access;
    S_Decompresse : Stream_Access;
    octet_fin : Integer;
    octet_lu : T_Char;
    Fin_Tableau : Boolean;
    nb_char : Integer;
    Code : Unbounded_String;
    Code_AB : Unbounded_String;
    Arb_Huff : T_AB;
    Tab_Huff : T_TAB_HUFF;
    fin_texte : Boolean;
    Code_lu : Unbounded_String;
    code_trouve : Boolean;
    j : Integer;
    Code_tmp : Unbounded_String;
    Nom_fichier_error : Exception;
    Command_error : Exception;
    Option_error : Exception;
    Affichage : Boolean;
    Num_Arg_Nom : Integer;
    Fichier_Vide_Erreur : Exception;

begin
    if Argument_Count = 0 then
        -- Afficher un message à l'utilisateur.
        raise Command_error;
        -- Effectuer la décompression.
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

    while Num_Arg_Nom <= Argument_Count loop
        begin

            Nom_Texte_Compresse_US := To_Unbounded_String(Argument(Num_Arg_Nom));

            if Length(Nom_Texte_Compresse_US) < 4 then
                raise Nom_fichier_error;
            elsif Unbounded_Slice(Nom_Texte_Compresse_US, Length(Nom_Texte_Compresse_US)-3,Length(Nom_Texte_Compresse_US)) /= To_Unbounded_String(".hff") then
                raise Nom_fichier_error;
            else
                Nom_Texte_Decompresse_US := Unbounded_Slice(Nom_Texte_Compresse_US,1,Length(Nom_Texte_Compresse_US)-4);
            end if;

            -- Ouvrir le fichier compressé
            Open(Texte_Compresse, In_File, To_String(Nom_Texte_Compresse_US));
            -- Recréer la liste des caractères du texte dans leur ordre d’apparition lors d'un parcours infixe de l'arbre de Huffman                                                                              lors d’un parcours infixe de l’arbre de Huffman
            Tab_Caract.Taille := 0;
            S_Compresse := Stream(Texte_Compresse);

            if End_Of_File(Texte_Compresse) then
                raise Fichier_Vide_Erreur;
            end if;

            octet_fin := Integer(T_Octet'Input(S_Compresse));
            octet_lu := Character'Pos(Character'Val(T_Octet'Input(S_Compresse)));

            loop
                -- Rajouter un élément dans le tableau puis lire un octet
                if Tab_Caract.Taille = octet_fin - 1 then
                    Tab_Caract.Taille := Tab_Caract.Taille + 1;
                    Tab_Caract.Tableau(Tab_Caract.Taille) := -1;
                    Tab_Caract.Taille := Tab_Caract.Taille + 1;
                    Tab_Caract.Tableau(Tab_Caract.Taille) := octet_lu;
                else
                    Tab_Caract.Taille := Tab_Caract.Taille + 1;
                    Tab_Caract.Tableau(Tab_Caract.Taille) := octet_lu;
                end if;
                octet_lu := Character'Pos(Character'Val(T_Octet'Input(S_Compresse)));
                Fin_Tableau := octet_lu = Tab_Caract.Tableau(Tab_Caract.Taille);
                exit when Fin_Tableau;
            end loop;

            -- Recréer l’arbre de Huffman à partir de la liste précédente et de l’arbre codé dans le fichier

            -- Enregistrer le code de l'arbre
            nb_char := 0;
            Code := To_Unbounded_String(T_Octet'Input(S_Compresse));
            Code_AB := To_Unbounded_String("");

            while nb_char < Tab_Caract.Taille loop
                if Length(Code) = 0 then
                    Code := To_Unbounded_String(T_Octet'Input(S_Compresse));
                else
                    Code_AB := Code_AB & Unbounded_Slice(Code,1,1);
                    if Unbounded_Slice(Code,1,1) = To_Unbounded_String("1") then
                        nb_char := nb_char + 1;
                    end if;
                    Delete(Code,1,1);
                end if;
            end loop;

            Initialiser_AB(Arb_Huff);
            Creer_AB_Huff(Arb_Huff, Tab_Caract, Code_AB);

            Create (Texte_Decompresse, Out_File, To_String(Nom_Texte_Decompresse_US));

            -- Afficher l'arbre si l'option bavard a été utilisée
            if Affichage then
                Put("Décompression du fichier " & To_String(Nom_Texte_Compresse_US) & ":");
                New_Line;
                Put("Arbre de Huffman :");
                New_Line;
                Afficher_AB(Arb_Huff);
                New_Line;
            end if;

            -- Ajouter dans ce fichier les caractères décodés à l’aide de l’arbre de Huffman

            Initialiser(Tab_Huff);
            Creer_Table(Tab_Huff, Arb_Huff);
            Vider_AB(Arb_Huff);

            -- Afficher la table de Huffman si l'option bavard a été utilisée
            if Affichage then
                Put("Table de Huffman :");
                New_Line;
                Afficher_Table(Tab_Huff);
                New_Line;
            end if;

            fin_texte := False;

            S_Decompresse := Stream(Texte_Decompresse);
            code_tmp := Code;
            Code := To_Unbounded_String("");
            for i in 1..Length(Code_tmp) loop

                -- Rechercher le code dans la table de Huffman et rajouter le caractère correspondant si un code correspond
                code_trouve := False;
                j := 1;
                code := code & Element(Code_tmp, i);
                while (not(code_trouve) and then j<= Taille_table(tab_huff)) loop
                    if Code = Code_Indice(Tab_Huff,j) then
                        if j = octet_fin then
                            fin_texte := True;
                        else
                            Character'Write(S_Decompresse, Character'Val(Caractere_Indice(Tab_huff,j)));
                            code_trouve := True;
                            Code := To_Unbounded_String("");
                        end if;
                    end if;
                    j := j + 1;
                end loop;
            end loop;

            -- Continuer à ajouter dans ce fichier les caractères décodés à l’aide de l’arbre de Huffman
            while not End_Of_File(Texte_Compresse) loop
                Code_lu := To_Unbounded_String(T_Octet'Input(S_Compresse));
                for i in 1..8 loop
                    Code := Code & Unbounded_Slice(Code_lu,1,1);
                    Delete(Code_lu,1,1);

                    --Rechercher le code dans la table de Huffman et rajouter le caractère correspondant si un code correspond (pour le reste du texte)

                    code_trouve := False;
                    j := 1;
                    while (not fin_texte and then not code_trouve  and then j<= Taille_table(tab_huff)) loop
                        if Code = Code_Indice(Tab_Huff,j) then
                            if j = octet_fin then
                                fin_texte := True;
                            else
                                Character'Write(S_Decompresse, Character'Val(Caractere_Indice(Tab_huff,j)));
                                code_trouve := True;
                                Code := To_Unbounded_String("");
                            end if;
                        end if;
                        j := j + 1;
                    end loop;
                end loop;
            end loop;

            Close(Texte_Compresse);
            Close(Texte_Decompresse);

            Put("Le fichier " & To_String(Nom_Texte_Compresse_US) & " a bien été décompressé");
            New_Line;

        exception
            when Command_error => Afficher_Usage;
            when Nom_fichier_error => Put("Le fichier ");
                Put(To_String(Nom_Texte_Compresse_US));
                Put(" que vous voulez décompresser n'est pas au bon format");
                Afficher_Usage;
            when Ada.Text_IO.Name_Error => Put("Le fichier ");
                Put(To_String(Nom_Texte_Compresse_US));
                Put(" que vous voulez décompresser n'existe pas");
                Afficher_Usage;
            when Fichier_Vide_Erreur => Put("Le fichier ");
                Put(To_String(Nom_Texte_Compresse_US));
                Put(" que vous voulez décompresser est vide: on ne peut décompresser un fichier vide !");
                New_Line;
                Close(Texte_Compresse);
        end;

        Num_Arg_Nom := Num_Arg_Nom  + 1;
    end loop;
exception
    when Command_error => Afficher_Usage;
    when Option_error => Put_Line("L'option " & Argument(1) & " que vous voulez utiliser n'existe pas");
        Afficher_Usage;
end decompresser;




