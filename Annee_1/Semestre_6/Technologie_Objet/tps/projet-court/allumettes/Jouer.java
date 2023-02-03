package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Jouer {

	/* Nombre d'allumettes présentes initialement dans le jeu */
	static final int NB_INITIAL = 13;

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			verifierNombreArguments(args);
			boolean confiant = false;
			Joueur[] joueurs = new Joueur[2];
			try {
				for (int i = 0; i < args.length; i++) {
					if (args[i].contentEquals("-confiant")) {
						confiant = true;
					} else if (confiant) {
						joueurs[i - 1] = getJoueur(args[i]);
					} else {
						joueurs[i] = getJoueur(args[i]);
					}
				}
			} catch (ArrayIndexOutOfBoundsException e) {
				throw new ConfigurationException("Configuration de joueur incorrecte");
			}
			for (int i = 0; i <= 1; i++) {
				if (joueurs[i] == null) {
					throw new ConfigurationException("Pas assez de joueur");
				}
			}
			Arbitre arbitre = new Arbitre(joueurs[0], joueurs[1]);
			if (confiant) {
				arbitre.setConfiant();
			}
			Jeu jeu = new JeuAllumettes(Jouer.NB_INITIAL);
			arbitre.arbitrer(jeu);
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}

	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Jouer joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Jouer Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

	/** Récupérer le joueur depuis la chaine de caractère en argument.
	 * @param joueur Nom de la stratégie utilisée.
	 * @return joueur Joueur créé.
	 */
	public static Joueur getJoueur(String nomStratJoueur) {
		String[] nomStrategie = nomStratJoueur.split("@");
		String nom = nomStrategie[0];
		Strategie strategie = getStrategie(nomStrategie[1]);
		Joueur joueur = new Joueur(nom, strategie);
		return joueur;
	}

	/** Récupérer la stratégie depuis la chaine de caractère en argument.
	 * @param nomStrategie Nom de la stratégie utilisée.
	 * @return strategie Stratégie utilisée.
	 */
	public static Strategie getStrategie(String nomStrategie)
			throws ConfigurationException {
		Strategie strategie;
		switch (nomStrategie.toLowerCase()) {
		case "expert" :
			strategie = new StrategieExpert();
			break;
		case "humain" :
			strategie = new StrategieHumain();
			break;
		case "naif" :
			strategie = new StrategieNaif();
			break;
		case "rapide" :
			strategie = new StrategieRapide();
			break;
		case "tricheur" :
			strategie = new StrategieTricheur();
			break;
		default :
			throw new ConfigurationException("La stratégie que"
					+ " vous voulez choisir n'existe pas");
		}
		return strategie;
	}

}
