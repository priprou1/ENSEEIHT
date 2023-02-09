# Problème Affectation de commandes de clients au magasin cas 1

###############################  Model ###############################

###############################  Sets  ###############################

set COMMANDE; # Nom des différentes commandes clients

set FLUIDE; # Nom des différents fluides

set MAGASIN; # Nom des différents magasins

###################  Constants: Data to load   #########################

param fluidecommande{i in COMMANDE, j in FLUIDE}; # Fluides demandés par commandes

param fluidemagasin{i in MAGASIN, j in FLUIDE}; # Stocks de fluides par magasin

param coutmagasin{i in MAGASIN, j in FLUIDE}; # Coût unitaire par magasin d'origine

################### Variables ###################

var quantitefluide{i in MAGASIN, j in FLUIDE}, >=0; # matrice de quantité de fluide j pris dans le magasin i

###### Objective ######

minimize CoutTotal:
        sum{i in MAGASIN, j in FLUIDE} coutmagasin[i,j] * quantitefluide[i,j];

################### Constraints ###################

subject to

# La somme des quantités de fluide i est égale à la somme des quantités commandées
quantitefluidecommande{j in FLUIDE} : sum{i in MAGASIN} quantitefluide[i,j] = sum{i in COMMANDE} fluidecommande[i,j];

# La quantité de fluide prise dans chaque magasin est inférieure à la quantité initiale du magasin
quantitefluidemagasin{i in MAGASIN, j in FLUIDE} : quantitefluide[i,j] <= fluidemagasin[i,j];

printf "\n--------------------------------------------------------\n";
printf "Problème d'affectation de commandes de clients à différents magasins cas linéaire\n";
printf "-----Debut de la résolution -----\n \n";
solve;

printf "\n-----Fin de la résolution -----\n \n";
printf "Affichage de la solution : \n";
printf "Coût Total : %.2f\n", CoutTotal;
printf{j in FLUIDE, i in MAGASIN} "Quantité de fluide %s pris dans le magasin %s : %.2f\n", j, i, quantitefluide[i,j];
printf "\n";

end;

