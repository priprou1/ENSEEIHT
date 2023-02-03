package allumettes;

import java.util.Random;

/** Stratégie de jeu d'un joueur naif.
 ** Elle tire au hasard un nombre d'allumettes à retirer.
 * @author	Priscilia Gonthier
 */
public class StrategieNaif implements Strategie {

	private Random rand;

	/** Construire la stratégie naif.
	 */
	public StrategieNaif() {
		this.rand = new Random();
	}

	/** Donner le nombre d'allumettes à retirer par le joueur.
	 * @param jeu jeu en train d'être jouer.
	 * @param nomJoueur nom du joueur.
	 * @return nombre d'allumettes que le joueur veut retirer.
	 */
	public int getPrise(Jeu jeu, String nomJoueur) {
		int allumettesRestantes = jeu.getNombreAllumettes();
		int allumettesPrises;
		if (allumettesRestantes >= Jeu.PRISE_MAX) {
			allumettesPrises = rand.nextInt(Jeu.PRISE_MAX) + 1;
		} else {
			allumettesPrises = rand.nextInt(allumettesRestantes) + 1;
		}
		return allumettesPrises;
	}

}
