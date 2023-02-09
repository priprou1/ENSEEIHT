Problem:    PbEcommerce3
Rows:       23
Columns:    18 (18 integer, 6 binary)
Non-zeros:  78
Status:     INTEGER OPTIMAL
Objective:  CoutTotal = 368 (MINimum)

   No.   Row name        Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 CoutTotal                 368                             
     2 quantitefluidecommande[F1,D1]
                                   2             2             = 
     3 quantitefluidecommande[F1,D2]
                                   1             1             = 
     4 quantitefluidecommande[F2,D1]
                                   0            -0             = 
     5 quantitefluidecommande[F2,D2]
                                   3             3             = 
     6 quantitefluidemagasin[M1,F1]
                                   1                           2 
     7 quantitefluidemagasin[M1,F2]
                                   1                           1 
     8 quantitefluidemagasin[M2,F1]
                                   0                           1 
     9 quantitefluidemagasin[M2,F2]
                                   2                           2 
    10 quantitefluidemagasin[M3,F1]
                                   2                           2 
    11 quantitefluidemagasin[M3,F2]
                                   0                           1 
    12 trajet[M1,D1]
                                   0                          -0 
    13 trajet[M1,D2]
                                  -1                          -0 
    14 trajet[M2,D1]
                                   0                          -0 
    15 trajet[M2,D2]
                                  -1                          -0 
    16 trajet[M3,D1]
                                  -1                          -0 
    17 trajet[M3,D2]
                                   0                          -0 
    18 trajet2[M1,D1]
                                   0                          -0 
    19 trajet2[M1,D2]
                                  -7                          -0 
    20 trajet2[M2,D1]
                                   0                          -0 
    21 trajet2[M2,D2]
                                  -7                          -0 
    22 trajet2[M3,D1]
                                  -7                          -0 
    23 trajet2[M3,D2]
                                   0                          -0 

   No. Column name       Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 trajeteffectue[M1,D1]
                    *              0             0             1 
     2 trajeteffectue[M1,D2]
                    *              1             0             1 
     3 trajeteffectue[M2,D1]
                    *              0             0             1 
     4 trajeteffectue[M2,D2]
                    *              1             0             1 
     5 trajeteffectue[M3,D1]
                    *              1             0             1 
     6 trajeteffectue[M3,D2]
                    *              0             0             1 
     7 quantitefluide[M1,F1,D1]
                    *              0             0               
     8 quantitefluide[M1,F1,D2]
                    *              1             0               
     9 quantitefluide[M1,F2,D1]
                    *              0             0               
    10 quantitefluide[M1,F2,D2]
                    *              1             0               
    11 quantitefluide[M2,F1,D1]
                    *              0             0               
    12 quantitefluide[M2,F1,D2]
                    *              0             0               
    13 quantitefluide[M2,F2,D1]
                    *              0             0               
    14 quantitefluide[M2,F2,D2]
                    *              2             0               
    15 quantitefluide[M3,F1,D1]
                    *              2             0               
    16 quantitefluide[M3,F1,D2]
                    *              0             0               
    17 quantitefluide[M3,F2,D1]
                    *              0             0               
    18 quantitefluide[M3,F2,D2]
                    *              0             0               

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
