@doc doc"""

#### Objet
Cette fonction calcule une solution approchée du problème
```math
\min_{||s||< \Delta} s^{t}g + \frac{1}{2}s^{t}Hs
```
par le calcul du pas de Cauchy.

#### Syntaxe
```julia
s, e = Pas_De_Cauchy(g,H,Δ)
```

#### Entrées
 - g : (Array{Float,1}) un vecteur de ``\mathbb{R}^n``
 - H : (Array{Float,2}) une matrice symétrique de ``\mathbb{R}^{n\times n}``
 - Δ  : (Float) le rayon de la région de confiance

#### Sorties
 - s : (Array{Float,1}) une approximation de la solution du sous-problème
 - e : (Integer) indice indiquant l'état de sortie:
        si g != 0
            si on ne sature pas la boule
              e <- 1
            sinon
              e <- -1
        sinon
            e <- 0

#### Exemple d'appel
```julia
g = [0; 0]
H = [7 0 ; 0 2]
Δ = 1
s, e = Pas_De_Cauchy(g,H,Δ)
```
"""
function Pas_De_Cauchy(g,H,Δ)

    e = 0
    n = length(g)
    s = zeros(n)
    normg = norm(g)
    borne = Δ / normg
    tol = 1e-10

    a = g' * H * g
    b = - normg^2
    tbar = -b/a

    if normg >= tol
         if a <= 0
             t = borne
             e = -1
         elseif tbar <= borne
             t = tbar
             e = 1
         else
             t = borne
             e = -1
         end
         s = -t * g
    else
        s = g
        e = 0
    end
    return s, e
end
