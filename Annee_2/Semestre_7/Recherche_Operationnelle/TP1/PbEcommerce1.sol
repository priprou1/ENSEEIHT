Problem:    PbEcommerce1
Rows:       9
Columns:    6
Non-zeros:  18
Status:     OPTIMAL
Objective:  CoutTotal = 9.5 (MINimum)

   No.   Row name   St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 CoutTotal    B            9.5                             
     2 quantitefluidecommande[F1]
                    NS             3             3             =             2 
     3 quantitefluidecommande[F2]
                    NS             3             3             =             3 
     4 quantitefluidemagasin[M1,F1]
                    NU           2.5                         2.5            -1 
     5 quantitefluidemagasin[M1,F2]
                    NU             1                           1            -2 
     6 quantitefluidemagasin[M2,F1]
                    B            0.5                           1 
     7 quantitefluidemagasin[M2,F2]
                    B              1                           2 
     8 quantitefluidemagasin[M3,F1]
                    B              0                           2 
     9 quantitefluidemagasin[M3,F2]
                    NU             1                           1            -1 

   No. Column name  St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 quantitefluide[M1,F1]
                    B            2.5             0               
     2 quantitefluide[M1,F2]
                    B              1             0               
     3 quantitefluide[M2,F1]
                    B            0.5             0               
     4 quantitefluide[M2,F2]
                    B              1             0               
     5 quantitefluide[M3,F1]
                    NL             0             0                           1 
     6 quantitefluide[M3,F2]
                    B              1             0               

Karush-Kuhn-Tucker optimality conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.DE: max.abs.err = 0.00e+00 on column 0
        max.rel.err = 0.00e+00 on column 0
        High quality

KKT.DB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
