package allumettes;

/** Stratégie de jeu d'un joueur expert.
 ** Elle fait en sorte qu'il gagne toujours.
 * @author	Priscilia Gonthier
 */
public class StrategieExpert implements Strategie {

	/** Donner le nombre d'allumettes à retirer par le joueur.
	 * @param jeu jeu en train d'être jouer.
	 * @param nomJoueur nom du joueur.
	 * @return nombre d'allumettes que le joueur veut retirer.
	 */
	public int getPrise(Jeu jeu, String nomJoueur) {
		int allumettesRestantes = jeu.getNombreAllumettes();
		int allumettesPrises;
		if (allumettesRestantes == 1) {
			allumettesPrises = allumettesRestantes;
		} else if (allumettesRestantes <= Jeu.PRISE_MAX + 1) {
			allumettesPrises = allumettesRestantes - 1;
		} else if (allumettesRestantes % (Jeu.PRISE_MAX + 1) <= 1) {
			allumettesPrises = Jeu.PRISE_MAX;
		} else {
			allumettesPrises = allumettesRestantes % (Jeu.PRISE_MAX + 1) - 1;
		}
		return allumettesPrises;
	}
}
