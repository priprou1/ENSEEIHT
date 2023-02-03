package src.menus.boutons;

import javax.swing.*;

import src.Musique;

@SuppressWarnings("serial")
public class Bouton_Quitter extends Boutons {
	/**
	 * fenetre à quitter si on utilise cette commande
	 */
	private JFrame fenetre;
	
	public Bouton_Quitter(JFrame fenetre) {
		super();
		this.fenetre = fenetre;
		
		//this.setText(this.getNom());	
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.RED);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
	}
	
	@Override
	public void executer() {
		if (Bouton_Save.getPartieCourante() != null) {
			Bouton_Save.getPartieCourante().stopTimer();
		}
		Musique.stopMusique();
		this.fenetre.dispose();
		System.exit(0);
	}

	@Override
	public String getNom() {
		return "Quitter";
	}

	
	
}
