@doc doc"""

#### Objet

Minimise une fonction de ``\mathbb{R}^{n}`` à valeurs dans ``\mathbb{R}`` en utilisant l'algorithme des régions de confiance.

La solution approchées des sous-problèmes quadratiques est calculé
par le pas de Cauchy ou le pas issu de l'algorithme du gradient conjugue tronqué

#### Syntaxe
```julia
xmin, fxmin, flag, nb_iters = Regions_De_Confiance(algo,f,gradf,hessf,x0,option)
```

#### Entrées :

   - algo        : (String) string indicant la méthode à utiliser pour calculer le pas
        - "gct"   : pour l'algorithme du gradient conjugué tronqué
        - "cauchy": pour le pas de Cauchy
   - f           : (Function) la fonction à minimiser
   - gradf       : (Function) le gradient de la fonction f
   - hessf       : (Function) la hessiene de la fonction à minimiser
   - x0          : (Array{Float,1}) point de départ
   - options     : (Array{Float,1})
     - deltaMax       : utile pour les m-à-j de la région de confiance
                      ``R_{k}=\left\{x_{k}+s ;\|s\| \leq \Delta_{k}\right\}``
     - gamma1, gamma2 : ``0 < \gamma_{1} < 1 < \gamma_{2}`` pour les m-à-j de ``R_{k}``
     - eta1, eta2     : ``0 < \eta_{1} < \eta_{2} < 1`` pour les m-à-j de ``R_{k}``
     - delta0         : le rayon de départ de la région de confiance
     - max_iter       : le nombre maximale d'iterations
     - Tol_abs        : la tolérence absolue
     - Tol_rel        : la tolérence relative
     - ϵ       : epsilon pour les tests de stagnation

#### Sorties:

   - xmin    : (Array{Float,1}) une approximation de la solution du problème :
               ``\min_{x \in \mathbb{R}^{n}} f(x)``
   - fxmin   : (Float) ``f(x_{min})``
   - flag    : (Integer) un entier indiquant le critère sur lequel le programme s'est arrêté (en respectant cet ordre de priorité si plusieurs critères sont vérifiés)
      - 0    : CN1
      - 1    : stagnation du ``x``
      - 2    : stagnation du ``f``
      - 3    : nombre maximal d'itération dépassé
   - nb_iters : (Integer)le nombre d'iteration qu'à fait le programme

#### Exemple d'appel
```julia
algo="gct"
f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
x0 = [1; 0]
options = []
xmin, fxmin, flag, nb_iters = Regions_De_Confiance(algo,f,gradf,hessf,x0,options)
```
"""
function Regions_De_Confiance(algo,f::Function,gradf::Function,hessf::Function,x0,options; gctcommecauchy=false)

include("Pas_De_Cauchy.jl")
include("Gradient_Conjugue_Tronque.jl")

    if options == []
        Δmax = 10
        γ₁ = 0.5
        γ₂ = 2.00
        η₁ = 0.25
        η₂ = 0.75
        Δ₀ = 2
        max_iter = 1000
        Tol_abs = sqrt(eps())
        Tol_rel = 1e-15
        ϵ = 1.e-2
    else
        Δmax = options[1]
        γ₁ = options[2]
        γ₂ = options[3]
        η₁ = options[4]
        η₂ = options[5]
        Δ₀ = options[6]
        max_iter = options[7]
        Tol_abs = options[8]
        Tol_rel = options[9]
        ϵ = options[10]
    end

    n = length(x0)
    xmin = x0
    fxmin = f(xmin)
    gradf₀ = gradf(xmin)
    gradfxmin = gradf₀
    hessfxmin = hessf(xmin)
    normgradf₀ = norm(gradf₀)
    flag = 0
    nb_iters = 0
    Δ = Δ₀
    arret = (normgradf₀ <= max(Tol_rel*normgradf₀,Tol_abs))
    zeroₙ = zeros(n)
    verifStagnation = false

    if gctcommecauchy
        itergct = 1
    else
        itergct = 2*n
    end

    m(s) = fxmin + gradfxmin' * s + 1/2 * s' * hessfxmin * s

    while !arret
        if algo == "cauchy"
            s, e = Pas_De_Cauchy(gradfxmin, hessfxmin, Δ)
        elseif algo == "gct"
            s = Gradient_Conjugue_Tronque(gradfxmin, hessfxmin, [Δ, itergct, 1e-12])
        end
        ρ = (fxmin - f(xmin + s))/(m(zeroₙ)-m(s))
        if ρ >= η₁
            xₖ = xmin
            xmin = xmin + s
            verifStagnation = true
            fxₖ = fxmin
            fxmin = f(xmin)
            gradfxmin = gradf(xmin)
            hessfxmin = hessf(xmin)
        end
        if ρ >= η₂
            Δ = min(γ₂ * Δ, Δmax)
        elseif ρ >= η₁
            Δ = Δ
        else
            Δ = γ₁ * Δ
        end
        nb_iters = nb_iters + 1

        #condition d'arrêt
        if (verifStagnation && norm(gradfxmin) <= max(Tol_rel * normgradf₀,Tol_abs))
            flag = 0
            arret = true
        elseif (verifStagnation && norm(xmin-xₖ) <= ϵ * max(Tol_rel * norm(xₖ), Tol_abs))
            flag = 1
            arret = true
        elseif (verifStagnation && abs(fxmin-fxₖ) <= ϵ * max(Tol_rel * abs(fxₖ),Tol_abs))
            flag = 2
            arret = true
        elseif nb_iters >= max_iter
            flag = 3
            arret = true
        end
        verifStagnation = false
    end

    return xmin, fxmin, flag, nb_iters
end
