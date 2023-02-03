package allumettes;

/** Stratégie de jeu d'un joueur rapide.
 ** Elle prend toujours le nombre maximal d'allumettes
 ** afin de terminer la partie au plus vite.
 * @author	Priscilia Gonthier
 */
public class StrategieRapide implements Strategie {

	/** Donner le nombre d'allumettes à retirer par le joueur.
	 * @param jeu jeu en train d'être jouer.
	 * @param nomJoueur nom du joueur.
	 * @return nombre d'allumettes que le joueur veut retirer.
	 */
	public int getPrise(Jeu jeu, String nomJoueur) {
		int allumettesRestantes = jeu.getNombreAllumettes();
		int allumettesPrises;
		if (allumettesRestantes >= Jeu.PRISE_MAX) {
			allumettesPrises = Jeu.PRISE_MAX;
		} else {
			allumettesPrises = allumettesRestantes;
		}
		return allumettesPrises;
	}
}
