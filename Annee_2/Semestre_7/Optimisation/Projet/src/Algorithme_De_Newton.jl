
@doc doc"""
#### Objet
Cette fonction implémente l'algorithme de Newton pour résoudre un problème d'optimisation sans contraintes

#### Syntaxe
```julia
xmin,fmin,flag,nb_iters = Algorithme_de_Newton(f,gradf,hessf,x₀,option)
```

#### Entrées :
   - f       : (Function) la fonction à minimiser
   - gradf   : (Function) le gradient de la fonction f
   - hessf   : (Function) la hessienne de la fonction f
   - x₀      : (Array{Float,1}) première approximation de la solution cherchée
   - options : (Array{Float,1})
       - max_iter      : le nombre maximal d'iterations
       - Tol_abs       : la tolérence absolue
       - Tol_rel       : la tolérence relative
       - ϵ             : epsilon pour les tests de stagnation

#### Sorties:
   - xmin    : (Array{Float,1}) une approximation de la solution du problème  : ``\min_{x \in \mathbb{R}^{n}} f(x)``
   - fmin    : (Float) ``f(x_{min})``
   - flag    : (Integer) indique le critère sur lequel le programme s'est arrêté (en respectant cet ordre de priorité si plusieurs critères sont vérifiés)
      - 0    : CN1
      - 1    : stagnation du xₖ
      - 2    : stagnation du f
      - 3    : nombre maximal d'itération dépassé
   - nb_iters : (Integer) le nombre d'itérations faites par le programme

#### Exemple d'appel
```@example
f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
x₀ = [1; 0]
options = []
xmin,fmin,flag,nb_iters = Algorithme_De_Newton(f,gradf,hessf,x₀,options)
```
"""
function Algorithme_De_Newton(f::Function,gradf::Function,hessf::Function,x₀,options)

    "# Si options == [] on prends les paramètres par défaut"
    if options == []
        max_iter = 100
        Tol_abs = sqrt(eps())
        Tol_rel = 1e-15
        ϵ = 1.e-2
    else
        max_iter = options[1]
        Tol_abs = options[2]
        Tol_rel = options[3]
        ϵ = options[4]
    end
        xmin = x₀
        fmin = f(x₀)
        flag = 0
        nb_iters = 0
        gradf₀ = gradf(x₀)
        gradfxmin = gradf₀
        normgradf₀ = norm(gradf₀)
        arret = (normgradf₀<=max(Tol_rel*normgradf₀,Tol_abs))

    while ! arret
        d = hessf(xmin)\(- gradfxmin)
        xₖ = xmin
        fₖ = fmin
        xmin = xmin + d
        fmin = f(xmin)
        gradfxmin = gradf(xmin)
        nb_iters = nb_iters + 1
        #condition d'arrêt
        if norm(gradfxmin) <= max(Tol_rel*normgradf₀,Tol_abs)
            flag = 0
            arret = true
        elseif norm(xmin-xₖ) <= ϵ * max(Tol_rel * norm(xₖ), Tol_abs)
            flag = 1
            arret = true
        elseif abs(fmin-fₖ) <= ϵ * max(Tol_rel * abs(fₖ),Tol_abs)
            flag = 2
            arret = true
        elseif nb_iters >= max_iter
            flag = 3
            arret = true
        end

    end

    return xmin,fmin,flag,nb_iters
end
