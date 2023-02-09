Problem:    PbEcommerce4
Rows:       56
Columns:    216 (216 integer, 216 binary)
Non-zeros:  1230
Status:     INTEGER OPTIMAL
Objective:  DistanceTotal = 22 (MINimum)

   No.   Row name        Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 DistanceTotal
                                  22                             
     2 trajetinterne[ALPHA]
                                   0            -0             = 
     3 trajetinterne[C1]
                                   0            -0             = 
     4 trajetinterne[C2]
                                   0            -0             = 
     5 trajetinterne[C3]
                                   0            -0             = 
     6 trajetinterne[C4]
                                   0            -0             = 
     7 trajetinterne[C5]
                                   0            -0             = 
     8 lieudepart[ALPHA]
                                   1             1             = 
     9 lieuvisiteunique1[ALPHA]
                                   1             1             = 
    10 lieuvisiteunique1[C1]
                                   1             1             = 
    11 lieuvisiteunique1[C2]
                                   1             1             = 
    12 lieuvisiteunique1[C3]
                                   1             1             = 
    13 lieuvisiteunique1[C4]
                                   1             1             = 
    14 lieuvisiteunique1[C5]
                                   1             1             = 
    15 lieuvisiteUnique2[ALPHA]
                                   1             1             = 
    16 lieuvisiteUnique2[C1]
                                   1             1             = 
    17 lieuvisiteUnique2[C2]
                                   1             1             = 
    18 lieuvisiteUnique2[C3]
                                   1             1             = 
    19 lieuvisiteUnique2[C4]
                                   1             1             = 
    20 lieuvisiteUnique2[C5]
                                   1             1             = 
    21 visiteuniqueparpassage[1]
                                   1             1             = 
    22 visiteuniqueparpassage[2]
                                   1             1             = 
    23 visiteuniqueparpassage[3]
                                   1             1             = 
    24 visiteuniqueparpassage[4]
                                   1             1             = 
    25 visiteuniqueparpassage[5]
                                   1             1             = 
    26 visiteuniqueparpassage[6]
                                   1             1             = 
    27 ordrecoherent[ALPHA,1]
                                   0            -0             = 
    28 ordrecoherent[ALPHA,2]
                                   0            -0             = 
    29 ordrecoherent[ALPHA,3]
                                   0            -0             = 
    30 ordrecoherent[ALPHA,4]
                                   0            -0             = 
    31 ordrecoherent[ALPHA,5]
                                   0            -0             = 
    32 ordrecoherent[C1,1]
                                   0            -0             = 
    33 ordrecoherent[C1,2]
                                   0            -0             = 
    34 ordrecoherent[C1,3]
                                   0            -0             = 
    35 ordrecoherent[C1,4]
                                   0            -0             = 
    36 ordrecoherent[C1,5]
                                   0            -0             = 
    37 ordrecoherent[C2,1]
                                   0            -0             = 
    38 ordrecoherent[C2,2]
                                   0            -0             = 
    39 ordrecoherent[C2,3]
                                   0            -0             = 
    40 ordrecoherent[C2,4]
                                   0            -0             = 
    41 ordrecoherent[C2,5]
                                   0            -0             = 
    42 ordrecoherent[C3,1]
                                   0            -0             = 
    43 ordrecoherent[C3,2]
                                   0            -0             = 
    44 ordrecoherent[C3,3]
                                   0            -0             = 
    45 ordrecoherent[C3,4]
                                   0            -0             = 
    46 ordrecoherent[C3,5]
                                   0            -0             = 
    47 ordrecoherent[C4,1]
                                   0            -0             = 
    48 ordrecoherent[C4,2]
                                   0            -0             = 
    49 ordrecoherent[C4,3]
                                   0            -0             = 
    50 ordrecoherent[C4,4]
                                   0            -0             = 
    51 ordrecoherent[C4,5]
                                   0            -0             = 
    52 ordrecoherent[C5,1]
                                   0            -0             = 
    53 ordrecoherent[C5,2]
                                   0            -0             = 
    54 ordrecoherent[C5,3]
                                   0            -0             = 
    55 ordrecoherent[C5,4]
                                   0            -0             = 
    56 ordrecoherent[C5,5]
                                   0            -0             = 

   No. Column name       Activity     Lower bound   Upper bound
------ ------------    ------------- ------------- -------------
     1 trajeteffectue[1,ALPHA,ALPHA]
                    *              0             0             1 
     2 trajeteffectue[1,ALPHA,C1]
                    *              0             0             1 
     3 trajeteffectue[1,ALPHA,C2]
                    *              1             0             1 
     4 trajeteffectue[1,ALPHA,C3]
                    *              0             0             1 
     5 trajeteffectue[1,ALPHA,C4]
                    *              0             0             1 
     6 trajeteffectue[1,ALPHA,C5]
                    *              0             0             1 
     7 trajeteffectue[1,C1,ALPHA]
                    *              0             0             1 
     8 trajeteffectue[1,C1,C1]
                    *              0             0             1 
     9 trajeteffectue[1,C1,C2]
                    *              0             0             1 
    10 trajeteffectue[1,C1,C3]
                    *              0             0             1 
    11 trajeteffectue[1,C1,C4]
                    *              0             0             1 
    12 trajeteffectue[1,C1,C5]
                    *              0             0             1 
    13 trajeteffectue[1,C2,ALPHA]
                    *              0             0             1 
    14 trajeteffectue[1,C2,C1]
                    *              0             0             1 
    15 trajeteffectue[1,C2,C2]
                    *              0             0             1 
    16 trajeteffectue[1,C2,C3]
                    *              0             0             1 
    17 trajeteffectue[1,C2,C4]
                    *              0             0             1 
    18 trajeteffectue[1,C2,C5]
                    *              0             0             1 
    19 trajeteffectue[1,C3,ALPHA]
                    *              0             0             1 
    20 trajeteffectue[1,C3,C1]
                    *              0             0             1 
    21 trajeteffectue[1,C3,C2]
                    *              0             0             1 
    22 trajeteffectue[1,C3,C3]
                    *              0             0             1 
    23 trajeteffectue[1,C3,C4]
                    *              0             0             1 
    24 trajeteffectue[1,C3,C5]
                    *              0             0             1 
    25 trajeteffectue[1,C4,ALPHA]
                    *              0             0             1 
    26 trajeteffectue[1,C4,C1]
                    *              0             0             1 
    27 trajeteffectue[1,C4,C2]
                    *              0             0             1 
    28 trajeteffectue[1,C4,C3]
                    *              0             0             1 
    29 trajeteffectue[1,C4,C4]
                    *              0             0             1 
    30 trajeteffectue[1,C4,C5]
                    *              0             0             1 
    31 trajeteffectue[1,C5,ALPHA]
                    *              0             0             1 
    32 trajeteffectue[1,C5,C1]
                    *              0             0             1 
    33 trajeteffectue[1,C5,C2]
                    *              0             0             1 
    34 trajeteffectue[1,C5,C3]
                    *              0             0             1 
    35 trajeteffectue[1,C5,C4]
                    *              0             0             1 
    36 trajeteffectue[1,C5,C5]
                    *              0             0             1 
    37 trajeteffectue[2,ALPHA,ALPHA]
                    *              0             0             1 
    38 trajeteffectue[2,ALPHA,C1]
                    *              0             0             1 
    39 trajeteffectue[2,ALPHA,C2]
                    *              0             0             1 
    40 trajeteffectue[2,ALPHA,C3]
                    *              0             0             1 
    41 trajeteffectue[2,ALPHA,C4]
                    *              0             0             1 
    42 trajeteffectue[2,ALPHA,C5]
                    *              0             0             1 
    43 trajeteffectue[2,C1,ALPHA]
                    *              0             0             1 
    44 trajeteffectue[2,C1,C1]
                    *              0             0             1 
    45 trajeteffectue[2,C1,C2]
                    *              0             0             1 
    46 trajeteffectue[2,C1,C3]
                    *              0             0             1 
    47 trajeteffectue[2,C1,C4]
                    *              0             0             1 
    48 trajeteffectue[2,C1,C5]
                    *              0             0             1 
    49 trajeteffectue[2,C2,ALPHA]
                    *              0             0             1 
    50 trajeteffectue[2,C2,C1]
                    *              0             0             1 
    51 trajeteffectue[2,C2,C2]
                    *              0             0             1 
    52 trajeteffectue[2,C2,C3]
                    *              1             0             1 
    53 trajeteffectue[2,C2,C4]
                    *              0             0             1 
    54 trajeteffectue[2,C2,C5]
                    *              0             0             1 
    55 trajeteffectue[2,C3,ALPHA]
                    *              0             0             1 
    56 trajeteffectue[2,C3,C1]
                    *              0             0             1 
    57 trajeteffectue[2,C3,C2]
                    *              0             0             1 
    58 trajeteffectue[2,C3,C3]
                    *              0             0             1 
    59 trajeteffectue[2,C3,C4]
                    *              0             0             1 
    60 trajeteffectue[2,C3,C5]
                    *              0             0             1 
    61 trajeteffectue[2,C4,ALPHA]
                    *              0             0             1 
    62 trajeteffectue[2,C4,C1]
                    *              0             0             1 
    63 trajeteffectue[2,C4,C2]
                    *              0             0             1 
    64 trajeteffectue[2,C4,C3]
                    *              0             0             1 
    65 trajeteffectue[2,C4,C4]
                    *              0             0             1 
    66 trajeteffectue[2,C4,C5]
                    *              0             0             1 
    67 trajeteffectue[2,C5,ALPHA]
                    *              0             0             1 
    68 trajeteffectue[2,C5,C1]
                    *              0             0             1 
    69 trajeteffectue[2,C5,C2]
                    *              0             0             1 
    70 trajeteffectue[2,C5,C3]
                    *              0             0             1 
    71 trajeteffectue[2,C5,C4]
                    *              0             0             1 
    72 trajeteffectue[2,C5,C5]
                    *              0             0             1 
    73 trajeteffectue[3,ALPHA,ALPHA]
                    *              0             0             1 
    74 trajeteffectue[3,ALPHA,C1]
                    *              0             0             1 
    75 trajeteffectue[3,ALPHA,C2]
                    *              0             0             1 
    76 trajeteffectue[3,ALPHA,C3]
                    *              0             0             1 
    77 trajeteffectue[3,ALPHA,C4]
                    *              0             0             1 
    78 trajeteffectue[3,ALPHA,C5]
                    *              0             0             1 
    79 trajeteffectue[3,C1,ALPHA]
                    *              0             0             1 
    80 trajeteffectue[3,C1,C1]
                    *              0             0             1 
    81 trajeteffectue[3,C1,C2]
                    *              0             0             1 
    82 trajeteffectue[3,C1,C3]
                    *              0             0             1 
    83 trajeteffectue[3,C1,C4]
                    *              0             0             1 
    84 trajeteffectue[3,C1,C5]
                    *              0             0             1 
    85 trajeteffectue[3,C2,ALPHA]
                    *              0             0             1 
    86 trajeteffectue[3,C2,C1]
                    *              0             0             1 
    87 trajeteffectue[3,C2,C2]
                    *              0             0             1 
    88 trajeteffectue[3,C2,C3]
                    *              0             0             1 
    89 trajeteffectue[3,C2,C4]
                    *              0             0             1 
    90 trajeteffectue[3,C2,C5]
                    *              0             0             1 
    91 trajeteffectue[3,C3,ALPHA]
                    *              0             0             1 
    92 trajeteffectue[3,C3,C1]
                    *              0             0             1 
    93 trajeteffectue[3,C3,C2]
                    *              0             0             1 
    94 trajeteffectue[3,C3,C3]
                    *              0             0             1 
    95 trajeteffectue[3,C3,C4]
                    *              0             0             1 
    96 trajeteffectue[3,C3,C5]
                    *              1             0             1 
    97 trajeteffectue[3,C4,ALPHA]
                    *              0             0             1 
    98 trajeteffectue[3,C4,C1]
                    *              0             0             1 
    99 trajeteffectue[3,C4,C2]
                    *              0             0             1 
   100 trajeteffectue[3,C4,C3]
                    *              0             0             1 
   101 trajeteffectue[3,C4,C4]
                    *              0             0             1 
   102 trajeteffectue[3,C4,C5]
                    *              0             0             1 
   103 trajeteffectue[3,C5,ALPHA]
                    *              0             0             1 
   104 trajeteffectue[3,C5,C1]
                    *              0             0             1 
   105 trajeteffectue[3,C5,C2]
                    *              0             0             1 
   106 trajeteffectue[3,C5,C3]
                    *              0             0             1 
   107 trajeteffectue[3,C5,C4]
                    *              0             0             1 
   108 trajeteffectue[3,C5,C5]
                    *              0             0             1 
   109 trajeteffectue[4,ALPHA,ALPHA]
                    *              0             0             1 
   110 trajeteffectue[4,ALPHA,C1]
                    *              0             0             1 
   111 trajeteffectue[4,ALPHA,C2]
                    *              0             0             1 
   112 trajeteffectue[4,ALPHA,C3]
                    *              0             0             1 
   113 trajeteffectue[4,ALPHA,C4]
                    *              0             0             1 
   114 trajeteffectue[4,ALPHA,C5]
                    *              0             0             1 
   115 trajeteffectue[4,C1,ALPHA]
                    *              0             0             1 
   116 trajeteffectue[4,C1,C1]
                    *              0             0             1 
   117 trajeteffectue[4,C1,C2]
                    *              0             0             1 
   118 trajeteffectue[4,C1,C3]
                    *              0             0             1 
   119 trajeteffectue[4,C1,C4]
                    *              0             0             1 
   120 trajeteffectue[4,C1,C5]
                    *              0             0             1 
   121 trajeteffectue[4,C2,ALPHA]
                    *              0             0             1 
   122 trajeteffectue[4,C2,C1]
                    *              0             0             1 
   123 trajeteffectue[4,C2,C2]
                    *              0             0             1 
   124 trajeteffectue[4,C2,C3]
                    *              0             0             1 
   125 trajeteffectue[4,C2,C4]
                    *              0             0             1 
   126 trajeteffectue[4,C2,C5]
                    *              0             0             1 
   127 trajeteffectue[4,C3,ALPHA]
                    *              0             0             1 
   128 trajeteffectue[4,C3,C1]
                    *              0             0             1 
   129 trajeteffectue[4,C3,C2]
                    *              0             0             1 
   130 trajeteffectue[4,C3,C3]
                    *              0             0             1 
   131 trajeteffectue[4,C3,C4]
                    *              0             0             1 
   132 trajeteffectue[4,C3,C5]
                    *              0             0             1 
   133 trajeteffectue[4,C4,ALPHA]
                    *              0             0             1 
   134 trajeteffectue[4,C4,C1]
                    *              0             0             1 
   135 trajeteffectue[4,C4,C2]
                    *              0             0             1 
   136 trajeteffectue[4,C4,C3]
                    *              0             0             1 
   137 trajeteffectue[4,C4,C4]
                    *              0             0             1 
   138 trajeteffectue[4,C4,C5]
                    *              0             0             1 
   139 trajeteffectue[4,C5,ALPHA]
                    *              0             0             1 
   140 trajeteffectue[4,C5,C1]
                    *              0             0             1 
   141 trajeteffectue[4,C5,C2]
                    *              0             0             1 
   142 trajeteffectue[4,C5,C3]
                    *              0             0             1 
   143 trajeteffectue[4,C5,C4]
                    *              1             0             1 
   144 trajeteffectue[4,C5,C5]
                    *              0             0             1 
   145 trajeteffectue[5,ALPHA,ALPHA]
                    *              0             0             1 
   146 trajeteffectue[5,ALPHA,C1]
                    *              0             0             1 
   147 trajeteffectue[5,ALPHA,C2]
                    *              0             0             1 
   148 trajeteffectue[5,ALPHA,C3]
                    *              0             0             1 
   149 trajeteffectue[5,ALPHA,C4]
                    *              0             0             1 
   150 trajeteffectue[5,ALPHA,C5]
                    *              0             0             1 
   151 trajeteffectue[5,C1,ALPHA]
                    *              0             0             1 
   152 trajeteffectue[5,C1,C1]
                    *              0             0             1 
   153 trajeteffectue[5,C1,C2]
                    *              0             0             1 
   154 trajeteffectue[5,C1,C3]
                    *              0             0             1 
   155 trajeteffectue[5,C1,C4]
                    *              0             0             1 
   156 trajeteffectue[5,C1,C5]
                    *              0             0             1 
   157 trajeteffectue[5,C2,ALPHA]
                    *              0             0             1 
   158 trajeteffectue[5,C2,C1]
                    *              0             0             1 
   159 trajeteffectue[5,C2,C2]
                    *              0             0             1 
   160 trajeteffectue[5,C2,C3]
                    *              0             0             1 
   161 trajeteffectue[5,C2,C4]
                    *              0             0             1 
   162 trajeteffectue[5,C2,C5]
                    *              0             0             1 
   163 trajeteffectue[5,C3,ALPHA]
                    *              0             0             1 
   164 trajeteffectue[5,C3,C1]
                    *              0             0             1 
   165 trajeteffectue[5,C3,C2]
                    *              0             0             1 
   166 trajeteffectue[5,C3,C3]
                    *              0             0             1 
   167 trajeteffectue[5,C3,C4]
                    *              0             0             1 
   168 trajeteffectue[5,C3,C5]
                    *              0             0             1 
   169 trajeteffectue[5,C4,ALPHA]
                    *              0             0             1 
   170 trajeteffectue[5,C4,C1]
                    *              1             0             1 
   171 trajeteffectue[5,C4,C2]
                    *              0             0             1 
   172 trajeteffectue[5,C4,C3]
                    *              0             0             1 
   173 trajeteffectue[5,C4,C4]
                    *              0             0             1 
   174 trajeteffectue[5,C4,C5]
                    *              0             0             1 
   175 trajeteffectue[5,C5,ALPHA]
                    *              0             0             1 
   176 trajeteffectue[5,C5,C1]
                    *              0             0             1 
   177 trajeteffectue[5,C5,C2]
                    *              0             0             1 
   178 trajeteffectue[5,C5,C3]
                    *              0             0             1 
   179 trajeteffectue[5,C5,C4]
                    *              0             0             1 
   180 trajeteffectue[5,C5,C5]
                    *              0             0             1 
   181 trajeteffectue[6,ALPHA,ALPHA]
                    *              0             0             1 
   182 trajeteffectue[6,ALPHA,C1]
                    *              0             0             1 
   183 trajeteffectue[6,ALPHA,C2]
                    *              0             0             1 
   184 trajeteffectue[6,ALPHA,C3]
                    *              0             0             1 
   185 trajeteffectue[6,ALPHA,C4]
                    *              0             0             1 
   186 trajeteffectue[6,ALPHA,C5]
                    *              0             0             1 
   187 trajeteffectue[6,C1,ALPHA]
                    *              1             0             1 
   188 trajeteffectue[6,C1,C1]
                    *              0             0             1 
   189 trajeteffectue[6,C1,C2]
                    *              0             0             1 
   190 trajeteffectue[6,C1,C3]
                    *              0             0             1 
   191 trajeteffectue[6,C1,C4]
                    *              0             0             1 
   192 trajeteffectue[6,C1,C5]
                    *              0             0             1 
   193 trajeteffectue[6,C2,ALPHA]
                    *              0             0             1 
   194 trajeteffectue[6,C2,C1]
                    *              0             0             1 
   195 trajeteffectue[6,C2,C2]
                    *              0             0             1 
   196 trajeteffectue[6,C2,C3]
                    *              0             0             1 
   197 trajeteffectue[6,C2,C4]
                    *              0             0             1 
   198 trajeteffectue[6,C2,C5]
                    *              0             0             1 
   199 trajeteffectue[6,C3,ALPHA]
                    *              0             0             1 
   200 trajeteffectue[6,C3,C1]
                    *              0             0             1 
   201 trajeteffectue[6,C3,C2]
                    *              0             0             1 
   202 trajeteffectue[6,C3,C3]
                    *              0             0             1 
   203 trajeteffectue[6,C3,C4]
                    *              0             0             1 
   204 trajeteffectue[6,C3,C5]
                    *              0             0             1 
   205 trajeteffectue[6,C4,ALPHA]
                    *              0             0             1 
   206 trajeteffectue[6,C4,C1]
                    *              0             0             1 
   207 trajeteffectue[6,C4,C2]
                    *              0             0             1 
   208 trajeteffectue[6,C4,C3]
                    *              0             0             1 
   209 trajeteffectue[6,C4,C4]
                    *              0             0             1 
   210 trajeteffectue[6,C4,C5]
                    *              0             0             1 
   211 trajeteffectue[6,C5,ALPHA]
                    *              0             0             1 
   212 trajeteffectue[6,C5,C1]
                    *              0             0             1 
   213 trajeteffectue[6,C5,C2]
                    *              0             0             1 
   214 trajeteffectue[6,C5,C3]
                    *              0             0             1 
   215 trajeteffectue[6,C5,C4]
                    *              0             0             1 
   216 trajeteffectue[6,C5,C5]
                    *              0             0             1 

Integer feasibility conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
