package editeur.commande;

import editeur.Ligne;

public class CommandeAfficherLigne extends CommandeLigne {

	public CommandeAfficherLigne(Ligne l) {
		super(l);
	}

	@Override
	public void executer() {
		String separation =
				"----------------------------------------------------";
		System.out.println(separation);
		ligne.afficher();
	}

	@Override
	public boolean estExecutable() {
		return true;
	}

}
