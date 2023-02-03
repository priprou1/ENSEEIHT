package allumettes;

import java.util.Scanner;

/** Stratégie de jeu d'un joueur humain.
 * @author	Priscilia Gonthier
 */
public class StrategieHumain implements Strategie {

	private static Scanner scanner = new Scanner(System.in);

	/** Donner le nombre d'allumettes à retirer par le joueur.
	 * @param jeu jeu en train d'être jouer.
	 * @param nomJoueur nom du joueur.
	 * @return nombre d'allumettes que le joueur veut retirer.
	 */
	public int getPrise(Jeu jeu, String nomJoueur) {
		String prise = "";
		try {
			System.out.print(nomJoueur
				+ ", combien d'allumettes ? ");
			prise = scanner.nextLine();
			return Integer.parseInt(prise);
		} catch (NumberFormatException e) {
			if (prise.equals("triche")) {
				try {
					jeu.retirer(1);
				} catch (CoupInvalideException e1) {
					e1.printStackTrace();
				}
				System.out.println("[Une allumette en moins, plus que "
						+ jeu.getNombreAllumettes() + ". Chut !]");
			} else {
				System.out.println("Vous devez donner un entier.");
			}
			return getPrise(jeu, nomJoueur);
		}
	}

}
