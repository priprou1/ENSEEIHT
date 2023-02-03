package menu;

public class SousMenu extends Menu implements Commande {

	Commande preambule;
	
	public SousMenu(String sonTitre, Commande preambule) {
		super(sonTitre);
		this.preambule = preambule;
	}

	@Override
	public void executer() {
		do {
			this.preambule.executer();
			super.afficher();
			super.selectionner();
			super.valider();
		} while (!super.estQuitte());
	}

	@Override
	public boolean estExecutable() {
		return true;
	}

}
