package src.menus.boutons;

import src.menus.fenetre_nomPartie.*;

@SuppressWarnings("serial")
public class Bouton_ValiderLancement extends Boutons {

    private NomPartie nomPartie;

    public Bouton_ValiderLancement(NomPartie nomPartie) {
        super();
		
		this.nomPartie = nomPartie;
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		this.addActionListener(this);
		

    }

    @Override
    public void executer() {
        nomPartie.launch();        
    }

    @Override
    public String getNom() {
        return "Valider";
    }
    
}
