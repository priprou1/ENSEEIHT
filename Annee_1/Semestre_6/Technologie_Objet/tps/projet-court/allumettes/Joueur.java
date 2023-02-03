package allumettes;

public class Joueur {

	private String nom;
	private Strategie strategie;

	/** Construire le joueur à partir de son nom et de sa stratégie.
	 * @param nom nom du joueur
	 * @param strategie stratégie du joueur
	 */
	Joueur(String nom, Strategie strategie) {
		this.nom = nom;
		this.strategie = strategie;
	}

	/** Donner le nom du joueur.
	 * @return nom du joueur.
	 */
	public String getNom() {
		return this.nom;
	}

	/** Donner le nombre d'allumettes à retirer.
	 * @param jeu jeu auquel le joueur joue.
	 * @return nombre d'allumettes à prendre.
	 */
	public int getPrise(Jeu jeu) {
		return this.strategie.getPrise(jeu, this.nom);
	}

	/** Changer la stratégie du joueur.
	 * @param strategie Nouvelle stratégie du joueur.
	 */
	public void setStrategie(Strategie strategie) {
		this.strategie = strategie;
	}
}
