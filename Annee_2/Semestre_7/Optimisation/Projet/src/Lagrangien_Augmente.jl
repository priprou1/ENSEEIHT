@doc doc"""
#### Objet

Résolution des problèmes de minimisation avec une contrainte d'égalité scalaire par l'algorithme du lagrangien augmenté.

#### Syntaxe
```julia
xmin,fxmin,flag,iter,μs,λs = Lagrangien_Augmente(algo,f,gradf,hessf,c,gradc,hessc,x₀,options)
```

#### Entrées
  - algo : (String) l'algorithme sans contraintes à utiliser:
    - "newton"  : pour l'algorithme de Newton
    - "cauchy"  : pour le pas de Cauchy
    - "gct"     : pour le gradient conjugué tronqué
  - f : (Function) la fonction à minimiser
  - gradf       : (Function) le gradient de la fonction
  - hessf       : (Function) la hessienne de la fonction
  - c     : (Function) la contrainte [x est dans le domaine des contraintes ssi ``c(x)=0``]
  - gradc : (Function) le gradient de la contrainte
  - hessc : (Function) la hessienne de la contrainte
  - x₀ : (Array{Float,1}) la première composante du point de départ du Lagrangien
  - options : (Array{Float,1})
    1. ϵ     : utilisé dans les critères d'arrêt
    2. tol         : la tolérance utilisée dans les critères d'arrêt
    3. itermax     : nombre maximal d'itération dans la boucle principale
    4. λ₀     : la deuxième composante du point de départ du Lagrangien
    5. μ₀, τ    : valeurs initiales des variables de l'algorithme

#### Sorties
- xmin : (Array{Float,1}) une approximation de la solution du problème avec contraintes
- fxmin : (Float) ``f(x_{min})``
- flag : (Integer) indicateur du déroulement de l'algorithme
   - 0    : convergence
   - 1    : nombre maximal d'itération atteint
   - (-1) : une erreur s'est produite
- niters : (Integer) nombre d'itérations réalisées
- μs : (Array{Float64,1}) tableau des valeurs prises par μₖ au cours de l'exécution
- λs : (Array{Float64,1}) tableau des valeurs prises par λₖ au cours de l'exécution

#### Exemple d'appel
```julia
using LinearAlgebra
algo = "gct" # ou newton|gct
f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
c(x) =  (x[1]^2) + (x[2]^2) -1.5
gradc(x) = [2*x[1] ;2*x[2]]
hessc(x) = [2 0;0 2]
x₀ = [1; 0]
options = []
xmin,fxmin,flag,iter,μs,λs = Lagrangien_Augmente(algo,f,gradf,hessf,c,gradc,hessc,x₀,options)
```

#### Tolérances des algorithmes appelés

Pour les tolérances définies dans les algorithmes appelés (Newton et régions de confiance), prendre les tolérances par défaut définies dans ces algorithmes.

"""
function Lagrangien_Augmente(algo,fonc::Function,contrainte::Function,gradfonc::Function,
        hessfonc::Function,grad_contrainte::Function,hess_contrainte::Function,x₀,options)

	include("Algorithme_De_Newton.jl")
	include("Regions_De_Confiance.jl")
    if options == []
		ϵ = 1e-2
		tol = 1e-5
		itermax = 1000
		λ₀ = 2
		μ₀ = 100
		τ = 2
	else
		ϵ = options[1]
		tol = options[2]
		itermax = options[3]
		λ₀ = options[4]
		μ₀ = options[5]
		τ = options[6]
	end

	Tol_abs = tol
	Tol_rel = tol
	iter = 0
	β = 0.9
	ηchap = 0.1258925
	α = 0.1
	ϵ₀ = 1 / μ₀
	η = ηchap/(μ₀^α)

  	xmin = x₀
	fxmin = 0
    flag = 0

  	μ = μ₀
  	μs = [μ₀]
  	λ = λ₀
  	λs = [λ₀]
	arret = false#(normgradf₀ <= max(Tol_rel*normgradf₀,Tol_abs))

	Lₐ(x) = fonc(x) + λ' * contrainte(x) + μ / 2 * norm(contrainte(x))^2# λ et μ à enlever dans la definition?
	gradLₐ(x) = gradfonc(x) + λ' * grad_contrainte(x) + μ * (contrainte(x) * grad_contrainte(x))
	hessLₐ(x) = hessfonc(x) + λ' * hess_contrainte(x) + μ * (contrainte(x) * hess_contrainte(x) + grad_contrainte(x) * grad_contrainte(x)')
	L(x) = fonc(x) + λ' * contrainte(x)
	gradL(x) = gradfonc(x) + λ' * grad_contrainte(x)

	normgradL₀ = norm(gradL(x₀))
	normC₀ = norm(contrainte(x₀))

	while !arret
		# Calculer xk
		xₖ = xmin
		fxₖ = fxmin
		if algo == "newton"
			xmin, fxmin, f, nb_iter = Algorithme_De_Newton(Lₐ,gradLₐ,hessLₐ,xₖ,[100, ϵ, 0, 0])
		else
			xmin, fxmin, f, nb_iter = Regions_De_Confiance(algo,Lₐ,gradLₐ,hessLₐ,xₖ, [10, 0.5, 2, 0.25, 0.75, 2, 1000, Tol_abs, Tol_rel ,ϵ])
		end

		if norm(contrainte(xmin)) <= η
			λ = λ + μ * contrainte(xmin)
			ϵ = ϵ/μ
			η = η / (μ^β)
		else
			μ = τ * μ
			ϵ = ϵ₀/μ
			η = ηchap/(μ^α)
		end

		append!(μs, [μ])
		append!(λs, [λ])

		#condition d'arrêt
        if (norm(gradL(xmin)) <= max(Tol_rel * normgradL₀,Tol_abs) && norm(contrainte(xmin)) <= max(Tol_rel * normC₀,Tol_abs))
            flag = 0
            arret = true
        elseif iter >= itermax
            flag = -1
            arret = true
        end
        verifStagnation = false
		iter = iter + 1
	end
        return xmin,fxmin,flag,iter, μs, λs
end
