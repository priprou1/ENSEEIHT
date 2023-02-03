package allumettes;

/** Arbitre un jeu lancé entre 2 joueurs.
 * @author	Priscilia Gonthier
 */
public class Arbitre {

	private Joueur joueur1;
	private Joueur joueur2;
	private Boolean confiant;

	/** Construire l'arbitre à partir des 2 joueurs donné en argument.
	 * @param j1 joueur1 qui commencera.
	 * @param j2 joueur2 qui jouera après.
	 */
	public Arbitre(Joueur j1, Joueur j2) {
		this.joueur1 = j1;
		this.joueur2 = j2;
		this.confiant = false;
	}

	/** Arbitrer le jeu donné en argument.
	 * @param jeu Jeu auquel les joueurs jouent.
	 */
	public void arbitrer(Jeu jeu) {
		Joueur joueurCourant = joueur1;
		Joueur joueurPerdant;
		Jeu jeuJoueur = this.confiant ? jeu : new Procuration(jeu);
		int allumettesPrises;
		try {
			while (jeu.getNombreAllumettes() != 0) {
				allumettesPrises = faireJouer(joueurCourant, jeuJoueur);
				jeu.retirer(allumettesPrises);
				joueurCourant = changerJoueur(joueurCourant);
			}
				joueurPerdant = changerJoueur(joueurCourant);
			System.out.println(joueurPerdant.getNom() + " perd !");
			System.out.println(joueurCourant.getNom() + " gagne !");
		} catch (CoupInvalideException e) {
			System.out.println("Impossible ! Nombre invalide : " + e.getCoup()
					+ "(" + e.getProbleme() + ")");
			if (joueurCourant == this.joueur2) {
				this.joueur2 = this.joueur1;
				this.joueur1 = joueurCourant;
			}
			arbitrer(jeu);
		} catch (OperationInterditeException e) {
				System.out.println("Abandon de la partie car " + joueurCourant.getNom()
				+ " triche !");
		}
	}

	/** Pour placer l'arbitre à confiant.
	 */
	public void setConfiant() {
		this.confiant = true;
	}

	/** Donner le joueur qui n'est pas en train de jouer.
	 * @return joueur qui n'est pas en train de jouer.
	 */
	private Joueur changerJoueur(Joueur joueurAncien) {
		return joueurAncien == this.joueur1 ? this.joueur2 : this.joueur1;
	}

	/** Fait jouer le joueur en cours.
	 * @param joueur joueur en train de jouer
	 * @param jeu jeu auquel les joueurs jouent.
	 * @return le nombre d'allumettes que le joueur veut retirer.
	 */
	public int faireJouer(Joueur joueur, Jeu jeu) {
		System.out.println("Allumettes restantes : " + jeu.getNombreAllumettes());
		int allumettesPrises = joueur.getPrise(jeu);
		System.out.println(joueur.getNom() + " prend "
				+ allumettesPrises + " allumette"
				+ (allumettesPrises <= 1 ? "" : "s") + ".");
		System.out.println();
		return allumettesPrises;
	}
}
