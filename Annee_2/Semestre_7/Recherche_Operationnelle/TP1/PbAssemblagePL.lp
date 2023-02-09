\* Problem : Assembler des voitures *\

Maximize
 Marge : + 10000 L + 9000 S
\* L = nombre de voiture de luxe construite *\
\* S = nombre de voiture standard construite *\

Subject To
 Surface_du_parking : + 10 L + 20 S <= 15000
 Nb_dheure_de_travail : + 0.06 L + 0.05 S <= 60
 Nb_maximal_de_voiture_de_Luxe : + L <= 800
 
End
