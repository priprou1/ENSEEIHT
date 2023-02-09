# Problème Affecter du personnel à un travail

###############################  Model ###############################

###############################  Sets  ###############################

set PERSONNEL; # nom des personnels

set TRAVAIL; # nom des travaux à effectuer


###################  Constants: Data to load   #########################

param coutformation{i in PERSONNEL, j in TRAVAIL};


################### Variables ###################

var affecte{i in PERSONNEL, j in TRAVAIL} binary; # matrice avec en ligne le personnel et en colonne le travail, afffecte(i,j) = 1 si le personnel i travaille sur le poste j et 0 sinon

###### Objective ######

minimize CoutTotal: 
		sum{i in PERSONNEL, j in TRAVAIL} coutformation[i,j]* affecte[i,j]; 

################### Constraints ###################

subject to

# Chaque personne est affectée à un unique travail
personneaffectee{i in PERSONNEL} : sum {j in TRAVAIL} affecte[i,j] = 1;

# Chaque travail est affecté à une unique personne
travailaffecte{j in TRAVAIL} : sum {i in PERSONNEL} affecte[i,j] = 1;

printf "\n--------------------------------------------------------\n";
printf "Problème de minimisation du coût de formation du personnel dans une entreprise\n";
printf "-----Debut de la résolution -----\n \n";
solve;

printf "\n-----Fin de la résolution -----\n \n";
printf "Affichage de la solution : \n";
printf "Coût minimal : %d\n", CoutTotal;
printf{i in PERSONNEL, j in TRAVAIL} (if affecte[i,j]=1 then "Affectation : %s -> %s (Coût formation : %d)\n" else ""), i, j, coutformation[i,j];
printf "\n";

end;