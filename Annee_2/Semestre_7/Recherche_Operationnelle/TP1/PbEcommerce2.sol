Problem:    PbEcommerce2
Rows:       9
Columns:    6 (6 integer, 0 binary)
Non-zeros:  18
Status:     INTEGER OPTIMAL
Objective:  CoutTotal = 10 (MINimum)

   No.   Row name        Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 CoutTotal                  10                             
     2 quantitefluidecommande[F1]
                                   3             3             = 
     3 quantitefluidecommande[F2]
                                   3             3             = 
     4 quantitefluidemagasin[M1,F1]
                                   2                           2 
     5 quantitefluidemagasin[M1,F2]
                                   1                           1 
     6 quantitefluidemagasin[M2,F1]
                                   1                           1 
     7 quantitefluidemagasin[M2,F2]
                                   1                           2 
     8 quantitefluidemagasin[M3,F1]
                                   0                           2 
     9 quantitefluidemagasin[M3,F2]
                                   1                           1 

   No. Column name       Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 quantitefluide[M1,F1]
                    *              2             0               
     2 quantitefluide[M1,F2]
                    *              1             0               
     3 quantitefluide[M2,F1]
                    *              1             0               
     4 quantitefluide[M2,F2]
                    *              1             0               
     5 quantitefluide[M3,F1]
                    *              0             0               
     6 quantitefluide[M3,F2]
                    *              1             0               

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
