# Problème Livraison de clients à partir d'un magasin cas 4

###############################  Model ###############################

###############################  Sets  ###############################

set DEPART; # Nom du lieu de départ du livreur (correspond au magasin)

set LIEU; # Nom des différents lieux, magasin et clients

set ORDREPASSAGE; # Ordre de passage du livreur

###################  Constants: Data to load   #########################

param distances{j in LIEU, k in LIEU}; # Distances entre le lieu i et le lieu k

param n; # Nombre total de lieux

################### Variables ###################

var trajeteffectue{i in ORDREPASSAGE, j in LIEU, k in LIEU}, binary; # matrice de variables binaires (1 si pour le passage numéro i il y a un trajet entre le lieu j et le lieu k, 0 sinon)

###### Objective ######

minimize DistanceTotal:
        sum{i in ORDREPASSAGE, j in LIEU, k in LIEU} distances[j,k] * trajeteffectue[i,j,k];

################### Constraints ###################

subject to

# Les trajets entre un lieu et lui-même sont nuls
trajetinterne{j in LIEU} : sum{i in ORDREPASSAGE} trajeteffectue[i,j,j] = 0;

# On commence par alpha :
lieudepart {d in DEPART} : sum{j in LIEU} trajeteffectue[1,d,j] = 1;


# Chaque lieu est visité une unique fois
lieuvisiteunique1{j in LIEU} : sum{k in LIEU, i in ORDREPASSAGE} trajeteffectue[i,j,k] = 1;
lieuvisiteUnique2{k in LIEU} : sum{j in LIEU, i in ORDREPASSAGE} trajeteffectue[i,j,k] = 1;
visiteuniqueparpassage{i in ORDREPASSAGE} : sum{j in LIEU, k in LIEU} trajeteffectue[i,j,k] = 1;

# Ajout de l'ordre de passage pour éviter la téléportation :
# le lieu de départ du trajet i+1 correspond au lieu d'arrivée du trajet i
ordrecoherent{j in LIEU, i in 1..(n-1)} : sum{l in LIEU} trajeteffectue[i+1,j,l] = sum{k in LIEU} trajeteffectue[i,k,j];

printf "\n--------------------------------------------------------\n";
printf "Problème de minimisation du trajet d'un livreur entre le magasin et les différents clients\n";
printf "-----Debut de la résolution -----\n \n";
solve;

printf "\n-----Fin de la résolution -----\n \n";
printf "Affichage de la solution : \n";
printf "Distance minimale : %d\n", DistanceTotal;
printf{i in ORDREPASSAGE, j in LIEU, k in LIEU} (if trajeteffectue[i,j,k]=1 then "Trajet %d : %s -> %s (Distance : %d)\n" else ""), i, j, k, distances[j,k];
printf "\n";

end;