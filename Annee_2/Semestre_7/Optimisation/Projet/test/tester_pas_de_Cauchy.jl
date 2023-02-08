@doc doc"""
Tester le pas de Cauchy

# Entrées :
   * afficher : (Bool) affichage ou non des résultats de chaque test

# Les cas de test (dans l'ordre)
   * fct 1 : x011,x012
   * fct 2 : x021,x022
"""

function tester_pas_cauchy(afficher::Bool,pas_de_cauchy::Function)

    @testset "Pas de cauchy" begin
        @testset "Cas 1 a=0 et g=0" begin
            g = [0,0]
            H = I
            delta = 1
            s, e = pas_de_cauchy(g, H, delta)
            @test s==[0,0]
            @test e==0
        end
        @testset "Cas 2 a=0 et H=0" begin
            g = [1,3]
            normg = norm(g)
            H = [0 0; 0 0]
            delta = 1
            s, e = pas_de_cauchy(g, H, delta)
            @test s==-(delta/normg)*g
            @test e==-1
        end
        @testset "Cas 3 a<0" begin
            g = [1,3]
            H = -I
            normg = norm(g)
            delta = 1
            s, e = pas_de_cauchy(g, H, delta)
            @test s==-(delta/normg)*g
            @test e==-1
        end
        @testset "Cas 4 a>0 Δ = 0.9 Δlim" begin
            H = I
            g = [1,3]
            normg=norm(g)
            deltalim = normg^3/(transpose(g)*H*g)
            delta = 0.9 * deltalim
            s, e = pas_de_cauchy(g, H, delta)
            @test s==-(delta/normg)*g
            @test e==-1
        end
        @testset "Cas 5 a>0 Δ = 1.1 Δlim" begin
            H = I
            g = [1,3]
            normg=norm(g)
            deltalim = normg^3/(transpose(g)*H*g)
            delta = 1.1 * deltalim
            s, e = pas_de_cauchy(g, H, delta)
            @test s==-(normg^2/(transpose(g)*H*g))*g
            @test e==1
        end
    end
end
