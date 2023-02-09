Problem:    PbPersonnel
Rows:       7
Columns:    9 (9 integer, 9 binary)
Non-zeros:  27
Status:     INTEGER OPTIMAL
Objective:  CoutTotal = 5 (MINimum)

   No.   Row name        Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 CoutTotal                   5                             
     2 personneaffectee[Marie]
                                   1             1             = 
     3 personneaffectee[Pierre]
                                   1             1             = 
     4 personneaffectee[Jean]
                                   1             1             = 
     5 travailaffecte[Coder]
                                   1             1             = 
     6 travailaffecte[Tester]
                                   1             1             = 
     7 travailaffecte[Rediger]
                                   1             1             = 

   No. Column name       Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 affecte[Marie,Coder]
                    *              1             0             1 
     2 affecte[Marie,Tester]
                    *              0             0             1 
     3 affecte[Marie,Rediger]
                    *              0             0             1 
     4 affecte[Pierre,Coder]
                    *              0             0             1 
     5 affecte[Pierre,Tester]
                    *              0             0             1 
     6 affecte[Pierre,Rediger]
                    *              1             0             1 
     7 affecte[Jean,Coder]
                    *              0             0             1 
     8 affecte[Jean,Tester]
                    *              1             0             1 
     9 affecte[Jean,Rediger]
                    *              0             0             1 

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
