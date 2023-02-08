function afficher_lagrangien(Lagrangien_Augmente::Function)
    lambda0 = 2
	mu0 = 10
	tho = 2
	epsilon = 1.
	tol = 1e-5
	max_iters = 1000
	options = [epsilon, tol, max_iters, lambda0, mu0, tho]
	algo = "gct"


	# Affichages
	# le cas de test 1
	xmin,fxmin,flag,nbiters, μ, λ = Lagrangien_Augmente(algo,fct1,contrainte1,grad_fct1,hess_fct1,grad_contrainte1,
	hess_contrainte1,pts2.x01,options)
	print("\nRésultats de : Lagrangien augmenté avec ", algo, " appliqué à fonction 1 au point initial x01 : \nμ₀ = ", μ[1], "\nλ₀ = ", λ[1], "\nμ_final = ", μ[end], "\nλ_final = ", λ[end])
	println("\n----------------------------------")
	# le cas de test 2
	xmin ,fxmin,flag,nbiters, μ, λ = Lagrangien_Augmente(algo,fct1,contrainte1,grad_fct1,hess_fct1,grad_contrainte1,
	hess_contrainte1,pts2.x02,options)
	print("\nRésultats de : Lagrangien augmenté avec ", algo, " appliqué à fonction 1 au point initial x02 : \nμ₀ = ", μ[1], "\nλ₀ = ", λ[1], "\nμ_final = ", μ[end], "\nλ_final = ", λ[end])
	println("\n----------------------------------")

	# le cas de test 3
	xmin,fxmin,flag,nbiters, μ, λ = Lagrangien_Augmente(algo,fct2,contrainte2,grad_fct2,hess_fct2,grad_contrainte2,
	hess_contrainte2,pts2.x03,options)
	print("\nRésultats de : Lagrangien augmenté avec ", algo, " appliqué à fonction 2 au point initial x03 : \nμ₀ = ", μ[1], "\nλ₀ = ", λ[1], "\nμ_final = ", μ[end], "\nλ_final = ", λ[end])
	println("\n----------------------------------")

	# le cas de test 4
	xmin ,fxmin,flag,nbiters, μ, λ = Lagrangien_Augmente(algo,fct2,contrainte2,grad_fct2,hess_fct2,grad_contrainte2,
	hess_contrainte2,pts2.x04,options)
	print("\nRésultats de : Lagrangien augmenté avec ", algo, " appliqué à fonction 2 au point initial x04 : \nμ₀ = ", μ[1], "\nλ₀ = ", λ[1], "\nμ_final = ", μ[end], "\nλ_final = ", λ[end])
	println("\n----------------------------------")

end

function comparer_tau(Lagrangien_Augmente::Function)
	lambda0 = 2
	mu0 = 10
	thos = 1:1:20
	epsilon = 1.
	tol = 1e-5
	max_iters = 1000

	iters = zeros(length(thos))
	μs = zeros(length(thos))

	algo = "gct"

	for i in 1:length(thos)
		options = [epsilon, tol, max_iters, lambda0, mu0, thos[i]]
		xmin,fxmin,flag,nbiters, μ, λ = Lagrangien_Augmente(algo,fct1,contrainte1,grad_fct1,hess_fct1,grad_contrainte1,
		hess_contrainte1,pts2.x01,options)
		iters[i] = nbiters
		μs[i] = μ[end]
	end


	p1 = plot(thos,iters)
	p1 = plot!(yscale=:log10, minorgrid=true)
	p1 = title!(L"Evolution du nombre d'itérations en fonction de la valeur de $\tau$")
	p1 = xlabel!(L"$\tau$")
	p1 = ylabel!("nombre d'itération")

	p2 = plot(thos,μs)
	p2 = title!(L"Evolution de $\mu$ en fonction de la valeur de $\tau$")
	p2 = xlabel!(L"$\tau$")
	p2 = ylabel!(L"\mu")


	plot(p1, p2, layout=(2,1), dpi=300, size=(900,1000))

end
