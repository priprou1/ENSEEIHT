function comparaison_regions_de_confiance_newton(Regions_De_Confiance::Function, Algorithme_De_Newton::Function)

	# initialisation des variables de l'algorithme
	gamma1 = 0.5
	gamma2 = 2.00
	eta1 = 0.25
	eta2 = 0.75
	deltaMax = 100
	Tol_abs = sqrt(eps())
	Tol_rel = 1e-15
	epsilon = 1
	maxits = 5000
	delta0 = 2

	optionsconf = [deltaMax,gamma1,gamma2,eta1,eta2,delta0,maxits,Tol_abs,Tol_rel,epsilon]
	optionsnewt = [maxits, Tol_abs, Tol_rel, epsilon]

	xminci, fminci, flagci, nb_itersci = Regions_De_Confiance("cauchy",fct1,grad_fct1,hess_fct1,sol_exacte_fct1,optionsconf)
	xminc1, fminc1, flagc1, nb_itersc1 = Regions_De_Confiance("cauchy",fct1,grad_fct1,hess_fct1,pts1.x011,optionsconf)
	xminc2, fminc2, flagc2, nb_itersc2 = Regions_De_Confiance("cauchy",fct1,grad_fct1,hess_fct1,pts1.x012,optionsconf)

	iterc = [nb_itersci, nb_itersc1, nb_itersc2]
	errc = [norm(sol_exacte_fct1-xminci), norm(sol_exacte_fct1-xminc1), norm(sol_exacte_fct1-xminc2)]

	xminni, fxminni, flagni, nb_itersni = Algorithme_De_Newton(fct1,grad_fct1,hess_fct1,sol_exacte_fct1,optionsnewt)
	xminn1, fxminn1, flagn1, nb_itersn1 = Algorithme_De_Newton(fct1,grad_fct1,hess_fct1,pts1.x011,optionsnewt)
	xminn2, fxminn2, flagn2, nb_itersn2 = Algorithme_De_Newton(fct1,grad_fct1,hess_fct1,pts1.x012,optionsnewt)

	itern = [nb_itersni, nb_itersn1, nb_itersn2]
	errn = [norm(sol_exacte_fct1-xminni), norm(sol_exacte_fct1-xminn1), norm(sol_exacte_fct1-xminn2)]

	println("\nerreur region de confiance : ", errc)
	println("\nerreur newton : ", errn)
	println("\niter region de confiance : ", iterc)
	println("\niter newton : ", itern)


end



function afficher_regions_de_confiance(Regions_De_Confiance::Function)

    # initialisation des variables de l'algorithme
	gamma1 = 0.5
	gamma1variable = 0.05:0.05:0.95
	gamma2 = 2.00
	gamma2variable = 1.1:0.05:3.0
	eta1 = 0.25
	eta1variable = 0.05:0.05:0.7
	eta2 = 0.75
	eta2variable = 0.3:0.05:0.95
	deltaMax = 100
	Tol_abs = sqrt(eps())
	Tol_rel = 1e-8
    epsilon = 1
	maxits = 5000
	delta02 = 0.01
	delta0 = 2

	itergamma1 = zeros(length(gamma1variable))
	itergamma2 = zeros(length(gamma2variable))
	itereta1 = zeros(length(eta1variable))
	itereta2 = zeros(length(eta2variable))

	xmingamma1 = zeros(length(gamma1variable))
	xmingamma2 = zeros(length(gamma2variable))
	xmineta1 = zeros(length(eta1variable))
	xmineta2 = zeros(length(eta2variable))

	# Lancement avec gamma1 qui varie
	for i in 1:length(gamma1variable)
		options = [deltaMax,gamma1variable[i],gamma2,eta1,eta2,delta0,maxits,Tol_abs,Tol_rel,epsilon]
		xmin, fmin, flag, nb_iters = Regions_De_Confiance("cauchy",fct2,grad_fct2,hess_fct2,pts1.x021,options)
		itergamma1[i] = nb_iters
		xmingamma1[i] = norm(xmin-sol_exacte_fct2)
	end

	# Lancement avec gamma2 qui varie
	for i in 1:length(gamma2variable)
		options = [deltaMax,gamma1,gamma2variable[i],eta1,eta2,delta02,maxits,Tol_abs,Tol_rel,epsilon]
		xmin, fmin, flag, nb_iters = Regions_De_Confiance("cauchy",fct1,grad_fct1,hess_fct1,pts1.x011,options)
		itergamma2[i] = nb_iters
		xmingamma2[i] = norm(xmin-sol_exacte_fct1)
	end

	# Lancement avec eta1 qui varie
	for i in 1:length(eta1variable)
		options = [deltaMax,gamma1,gamma2,eta1variable[i],eta2,delta0,maxits,Tol_abs,Tol_rel,epsilon]
		xmin, fmin, flag, nb_iters = Regions_De_Confiance("cauchy",fct2,grad_fct2,hess_fct2,pts1.x021,options)
		itereta1[i] = nb_iters
		xmineta1[i] = norm(xmin-sol_exacte_fct2)
	end

	# Lancement avec eta2 qui varie
	for i in 1:length(eta2variable)
		options = [deltaMax,gamma1,gamma2,eta1,eta2variable[i],delta0,maxits,Tol_abs,Tol_rel,epsilon]
		xmin, fmin, flag, nb_iters = Regions_De_Confiance("cauchy",fct2,grad_fct2,hess_fct2,pts1.x021,options)
		itereta2[i] = nb_iters
		xmineta2[i] = norm(xmin-sol_exacte_fct2)
	end

	# Affichages
	p1 = plot(gamma1variable,itergamma1,label=L"\gamma_1")
	p1 = title!("Evolution du nombre d'itérations")
	p1 = xlabel!(L"$\gamma_1$")
	p1 = ylabel!("nombre d'itération")

	p2 = plot(gamma1variable,xmingamma1,label=L"\gamma_1")
	p2 = plot!(yscale=:log10, minorgrid=true)
	p2 = title!("Evolution de la précision")
	p2 = xlabel!(L"$\gamma_1$")
	p2 = ylabel!(L"$||x_{min}-x_{sol}||$")

	p3 = plot(gamma2variable,itergamma2,label=L"\gamma_2")
	p3 = title!("Evolution du nombre d'itérations")
	p3 = xlabel!(L"$\gamma_2$")
	p3 = ylabel!("nombre d'itération")

	p4 = plot(gamma2variable,xmingamma2,label=L"\gamma_2")
	p4 = plot!(yscale=:log10, minorgrid=true)
	p4 = title!("Evolution de la précision")
	p4 = xlabel!(L"$\gamma_2$")
	p4 = ylabel!(L"$||x_{min}-x_{sol}||$")

	p5 = plot(eta1variable,itereta1,label=L"\eta_1")
	p5 = title!("Evolution du nombre d'itérations")
	p5 = xlabel!(L"$\eta_1$")
	p5 = ylabel!("nombre d'itération")

	p6 = plot(eta1variable,xmineta1,label=L"\eta_1")
	p6 = plot!(yscale=:log10, minorgrid=true)
	p6 = title!("Evolution de la précision")
	p6 = xlabel!(L"$\eta_1$")
	p6 = ylabel!(L"$||x_{min}-x_{sol}||$")

	p7 = plot(eta2variable,itereta2,label=L"\eta_2")
	p7 = title!("Evolution du nombre d'itérations")
	p7 = xlabel!(L"$\eta_2$")
	p7 = ylabel!("nombre d'itération")

	p8 = plot(eta2variable,xmineta2,label=L"\eta_2")
	p8 = title!("Evolution de la précision")
	p8 = xlabel!(L"$\eta_2$")
	p8 = ylabel!(L"$||x_{min}-x_{sol}||$")

	plot(p1, p2, p3, p4, p5, p6, p7, p8, layout=(4,2), dpi=300, size=(900,1000))

end

function comparaison_cauchy_gct(Regions_De_Confiance::Function)

	# initialisation des variables de l'algorithme
	gamma1 = 0.5
	gamma2 = 2.00
	eta1 = 0.25
	eta2 = 0.75
	deltaMax = 100
	Tol_abs = sqrt(eps())
	Tol_rel = 1e-8
	epsilon = 1
	maxits = 5000
	delta0 = 0.1:0.1:10


	iterc = zeros(length(delta0))
	itergct1 = zeros(length(delta0))
	itergct = zeros(length(delta0))


	for i in 1:length(delta0)
		optionsconf = [deltaMax,gamma1,gamma2,eta1,eta2,delta0[i],maxits,Tol_abs,Tol_rel,epsilon]
		xminc, fminc, flagc, nb_itersc = Regions_De_Confiance("cauchy",fct1,grad_fct1,hess_fct1,pts1.x012,optionsconf)
		iterc[i] = nb_itersc

		xmingct1, fmingct1, flaggct1, nb_itersgct1 = Regions_De_Confiance("gct",fct1,grad_fct1,hess_fct1,pts1.x012,optionsconf, gctcommecauchy=true)
		itergct1[i] = nb_itersgct1

		xmingct, fmingct, flaggct, nb_itersgct = Regions_De_Confiance("gct",fct1,grad_fct1,hess_fct1,pts1.x012,optionsconf)
		itergct[i] = nb_itersgct

	end

	plot(delta0,iterc,label="cauchy", dpi=300, size=(900,400))
	plot!(delta0,itergct1,label="GCT ordre 1", color="red",ls=:dashdotdot)
	plot!(delta0,itergct,label="GCT")
	plot!(yscale=:log10, minorgrid=true)
	title!(L"Evolution du nombre d'itérations en fonction de la valeur de $\delta_0$")
	xlabel!(L"$\Delta_0$")
	ylabel!("nombre d'itération")



end
