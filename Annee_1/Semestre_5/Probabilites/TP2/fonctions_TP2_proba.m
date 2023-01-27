
% TP2 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : Gonthier
% Prenom : Priscilia
% Groupe : 1SN-M

function varargout = fonctions_TP2_proba(varargin)

    switch varargin{1}
        
        case {'calcul_frequences_caracteres','determination_langue','coeff_compression','gain_compression','partitionnement_frequences'}

            varargout{1} = feval(varargin{1},varargin{2:end});
            
        case {'recuperation_caracteres_presents','tri_decroissant_frequences','codage_arithmetique'}
            
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
            
        case 'calcul_parametres_correlation'
            
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end});
            
    end

end

% Fonction calcul_frequences_caracteres (exercice_0.m) --------------------
function frequences = calcul_frequences_caracteres(texte,alphabet)
    % Note : initialiser le vecteur avec 'size(alphabet)' pour garder la bonne orientation
    [nb_lignes, nb_colonnes]=size(alphabet);    
    frequences = zeros(nb_lignes,nb_colonnes);
    for i=1:nb_lignes*nb_colonnes
        indices = find(texte==alphabet(i));%récupère les indices absolus où on a le caractère de l'alphabet en indice i 
        frequences(i)=length(indices);%le tableau frequence à l'indice absolu i prend la valeur du nombre de fois que le caractère à l'indice i dnas l'alphabet a été trouvé dans le texte
    end
    frequences = frequences / length(texte);%passe en fréquence
end

% Fonction recuperation_caracteres_presents (exercice_0.m) ----------------
function [selection_frequences,selection_alphabet] = ...
                      recuperation_caracteres_presents(frequences,alphabet)
    indices = find(frequences ~= 0);% récupère les indices des fréquences non nulles
    selection_frequences = frequences(indices);%garde que les fréquences non nulles
    selection_alphabet = alphabet(indices);%garde que les caratères de fréquence non nulle

end

% Fonction tri_decremental_frequences (exercice_0.m) ----------------------
function [frequences_triees,indices_frequences_triees] = ...
                           tri_decroissant_frequences(selection_frequences)
    [frequences_triees, indices_frequences_triees] = sort(selection_frequences, 'descend');

end

% Fonction determination_langue (exercice_1.m) ----------------------------
function indice_langue = determination_langue(frequences_texte, frequences_langue, nom_norme)
    % Note : la variable nom_norme peut valoir 'L1', 'L2' ou 'Linf'.
    
    switch nom_norme
        case 'L2'
            norm = sum((frequences_texte-frequences_langue).^2,2);%vecteur contenant la norme 2 par rapport à la langue i sur chaque ligne i

        case 'L1'
            norm = sum (abs(frequences_texte-frequences_langue),2);%vecteur contenant la norme 1 par rapport à la langue i sur chaque ligne i         
                     
        case 'Linf'
            norm = max(abs(frequences_texte-frequences_langue),[],2);%vecteur contenant la norme infinie par rapport à la langue i sur chaque ligne i

    end
    
    [valeur, indice_langue] = min (norm);

end

% Fonction coeff_compression (exercice_2.m) -------------------------------
function coeff_comp = coeff_compression(signal_non_encode,signal_encode)
    coeff_comp = (8*length(signal_non_encode))/length(signal_encode);%on multiplie par 8 car chaque caractère du signal non encodé est codé sur 8 bits dans sa version d'origine

end

% Fonction coeff_compression (exercice_2bis.m) -------------------------------
function gain_comp = gain_compression(coeff_comp_avant,coeff_comp_apres)
    gain_comp = coeff_comp_apres/coeff_comp_avant;

end

% Fonction partitionnement_frequences (exercice_3.m) ----------------------
function bornes = partitionnement_frequences(selection_frequences)
    frequences_linearisee = selection_frequences(:)';
    taille=length(frequences_linearisee);

    bornes = [0 cumsum(frequences_linearisee(1:taille-1)); cumsum(frequences_linearisee)];

end

% Fonction codage_arithmetique (exercice_3.m) -----------------------------
function [borne_inf,borne_sup] = ...
                       codage_arithmetique(texte,selection_alphabet,bornes)
    %Initialisation:
    borne_inf=0;
    borne_sup=1;
    %Algorithme:
    for i=1:length(texte) 
        j= find(selection_alphabet==texte(i));
        largeur=borne_sup-borne_inf;
        borne_sup=borne_inf+largeur*bornes(2,j);
        borne_inf=borne_inf+largeur*bornes(1,j);
    end  

end

%--------------------------------------------------------------------------
%Réponse à la question exercice 3:
%_________________________________
%L'algorithme de Huffman est inadapté lors de la répétition de plusieurs 
%caractères identiques consécutivement par exemple le mot 
% "abbbbbbbbbbbbbbbbbbbb" est codé en 3 bit en arithmétique et en 21 en
% Huffman.