@doc doc"""
#### Objet
Cette fonction calcule une solution approchée du problème

```math
\min_{||s||< \Delta}  q(s) = s^{t} g + \frac{1}{2} s^{t}Hs
```

par l'algorithme du gradient conjugué tronqué

#### Syntaxe
```julia
s = Gradient_Conjugue_Tronque(g,H,option)
```

#### Entrées :
   - g : (Array{Float,1}) un vecteur de ``\mathbb{R}^n``
   - H : (Array{Float,2}) une matrice symétrique de ``\mathbb{R}^{n\times n}``
   - options          : (Array{Float,1})
      - Δ    : le rayon de la région de confiance
      - max_iter : le nombre maximal d'iterations
      - tol      : la tolérance pour la condition d'arrêt sur le gradient

#### Sorties:
   - s : (Array{Float,1}) le pas s qui approche la solution du problème : ``min_{||s||< \Delta} q(s)``

#### Exemple d'appel:
```julia
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
xk = [1; 0]
options = []
s = Gradient_Conjugue_Tronque(gradf(xk),hessf(xk),options)
```
"""
function Gradient_Conjugue_Tronque(g,H,options)

    "# Si option est vide on initialise les 3 paramètres par défaut"
    if options == []
        Δ = 2
        max_iter = 100
        tol = 1e-6
    else
        Δ = options[1]
        max_iter = options[2]
        tol = options[3]
    end
    Tol_rel = tol
    Tol_abs = tol
    nb_iter = 0
    g₀ = g
    normg₀ = norm(g₀)
    n = length(g)
    s = zeros(n)
    p = -g
    q(x) = g' * x + (1/2) * x' * H * x

    while (nb_iter < max_iter && norm(g) > max(normg₀ * Tol_rel, Tol_abs))
        κ = p'*H*p
        if κ <= 0
            a = norm(p)^2
            b = 2 * s' * p
            c = norm(s)^2 - Δ^2
            Discriminant = b^2 - 4 * a * c
            σ₁ = (-b + sqrt(Discriminant))/(2 * a)
            σ₂ = (-b - sqrt(Discriminant))/(2 * a)
            s₁ = s + σ₁ * p
            s₂ = s + σ₂ * p
            if q(s₁) <= q(s₂)
                return s₁
            else
                return s₂
            end
        end
        α = (g' * g) / κ
        if norm(s + α * p) >= Δ
            a = norm(p)^2
            b = 2 * s' * p
            c = norm(s)^2 - Δ^2
            Discriminant = b^2 - 4 * a * c
            σ = (-b + sqrt(Discriminant))/(2 * a)
            return s + σ * p
        end
        s = s + α * p
        gₚᵣₑ = g
        g = g + α * H * p
        β = (g' * g)/ (gₚᵣₑ' * gₚᵣₑ)
        p = -g + β * p
        nb_iter = nb_iter + 1
    end
    return s
end
