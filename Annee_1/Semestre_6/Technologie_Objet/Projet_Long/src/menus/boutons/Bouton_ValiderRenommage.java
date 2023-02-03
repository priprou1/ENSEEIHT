package src.menus.boutons;

import src.menus.fenetre_renommer.*;

@SuppressWarnings("serial")
public class Bouton_ValiderRenommage extends Boutons {

    private NouveauNomPartie nouveauNomPartie;

    public Bouton_ValiderRenommage(NouveauNomPartie nouveauNomPartie) {
        super();
		
		this.nouveauNomPartie = nouveauNomPartie;
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		this.addActionListener(this);

    }

    @Override
    public void executer() {
        this.nouveauNomPartie.launch();
    }

    @Override
    public String getNom() {
        return "Renommer";
    }
    
}
