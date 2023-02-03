package allumettes;

/** Stratégie de jeu d'un joueur.
 * @author	Priscilia Gonthier
 */
public interface Strategie {

	/** Donner le nombre d'allumettes à retirer par le joueur.
	 * @param jeu jeu en train d'être jouer.
	 * @param nomJoueur nom du joueur.
	 * @return nombre d'allumettes que le joueur veut retirer.
	 */
	int getPrise(Jeu jeu, String nomJoueur);

}
