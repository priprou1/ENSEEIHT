# Problème Affectation de commandes de clients au magasin cas 3

###############################  Model ###############################

###############################  Sets  ###############################

set COMMANDE; # Nom des différentes commandes clients

set FLUIDE; # Nom des différents fluides

set MAGASIN; # Nom des différents magasins

###################  Constants: Data to load   #########################



param fluidecommande{k in COMMANDE, j in FLUIDE}; # Fluides demandés par commandes

param fluidemagasin{i in MAGASIN, j in FLUIDE}; # Stocks de fluides par magasin

param coutmagasin{i in MAGASIN, j in FLUIDE}; # Coût unitaire par magasin d'origine

param coutfixe{i in MAGASIN, k in COMMANDE}; # Coût fixe d'expedition d'un colis

param coutvariable{i in MAGASIN, k in COMMANDE}; # Coût variable d'expedition d'un colis

param bigm := sum{i in MAGASIN, j in FLUIDE} fluidemagasin[i,j]; # Calcul du big M à partir des stocks de fluide par magasin, pour les contraintes 

################### Variables ###################

var trajeteffectue{i in MAGASIN, k in COMMANDE}, binary; # matrice de variables binaires (1 si il y a un trajet entre le magasin i et la commande k, 0 sinon)

var quantitefluide{i in MAGASIN, j in FLUIDE, k in COMMANDE}, integer, >=0; # matrice de quantité de fluide j pris dans le magasin i pour la commande k

###### Objective ######

minimize CoutTotal:
        sum{i in MAGASIN, j in FLUIDE, k in COMMANDE} (coutmagasin[i,j] * quantitefluide[i,j,k]) # coût de chaque fluide
        + sum{i in MAGASIN, k in COMMANDE} (coutfixe[i,k] * trajeteffectue[i,k]) # coût fixe par voyage
        + sum{i in MAGASIN, j in FLUIDE, k in COMMANDE} (coutvariable[i,k] * quantitefluide[i,j,k]); # coût trasport pour chaque fluide 

################### Constraints ###################

subject to

# La somme des quantités de fluide i est égale à la somme des quantités commandées
quantitefluidecommande{j in FLUIDE, k in COMMANDE} : sum{i in MAGASIN} quantitefluide[i,j,k] = fluidecommande[k,j];

# La quantité de fluide prise dans chaque magasin est inférieure à la quantité initiale du magasin
quantitefluidemagasin{i in MAGASIN, j in FLUIDE} : sum{k in COMMANDE} quantitefluide[i,j,k] <= fluidemagasin[i,j];

# Il y a un trajet entre le magasin i et la commande k, alors trajeteffectue[i,k] est à 1, à 0 sinon, si le trajet effectué est nul alors la quantité de fluide est nulle aussi
trajet{i in MAGASIN, k in COMMANDE} : trajeteffectue[i,k] <= sum{j in FLUIDE} quantitefluide[i,j,k];

trajet2{i in MAGASIN, k in COMMANDE} : sum{j in FLUIDE} quantitefluide[i,j,k] <= trajeteffectue[i,k] * bigm;

printf "\n--------------------------------------------------------\n";
printf "Problème d'affectation de commandes de clients à différents";
printf " magasins cas linéaire en nombre entier avec prise en compte du coût des trajet\n";
printf "-----Debut de la résolution -----\n \n";
solve;

printf "\n-----Fin de la résolution -----\n \n";
printf "Affichage de la solution : \n";
printf "Coût Total : %d\n", CoutTotal;
printf{j in FLUIDE, i in MAGASIN, k in COMMANDE} "Quantité de fluide %s pris dans le magasin %s  pour la commande %s: %d\n", j, i, k, quantitefluide[i,j,k];
printf "\n";

end;