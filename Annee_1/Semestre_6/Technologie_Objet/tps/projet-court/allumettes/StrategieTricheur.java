package allumettes;

/** Stratégie de jeu d'un joueur tricheur.
 ** Elle va prendre le nombre d'allumettes nécessaire pour
 ** n'en laisser qu'une à l'adversaire et gagner la partie.
 * @author	Priscilia Gonthier
 */
public class StrategieTricheur implements Strategie {

	/** Donner le nombre d'allumettes à retirer par le joueur.
	 * @param jeu jeu en train d'être jouer.
	 * @param nomJoueur nom du joueur.
	 * @return nombre d'allumettes que le joueur veut retirer.
	 */
	public int getPrise(Jeu jeu, String nomJoueur) {
		try {
			System.out.println("[Je triche...]");
			while (jeu.getNombreAllumettes() > Jeu.PRISE_MAX + 1) {
				jeu.retirer(Jeu.PRISE_MAX);
			}
			jeu.retirer(jeu.getNombreAllumettes() - 2);
			System.out.println("[Allumettes restantes : 2]");
			return 1;
		} catch (CoupInvalideException e) {
			return 1;
		}
	}
}
