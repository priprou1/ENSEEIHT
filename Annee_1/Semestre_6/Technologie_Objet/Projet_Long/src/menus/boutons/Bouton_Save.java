package src.menus.boutons;

import src.sauvegarde.*;
import src.PartieCourante;
import javax.swing.*;

@SuppressWarnings("serial")
public class Bouton_Save extends Boutons {

	private JFrame fenetre;
    private static PartieCourante partie;
	
	public Bouton_Save(JFrame fenetre) {
		super();
		this.fenetre = fenetre;
		
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);
		
	}

	public static PartieCourante getPartieCourante() {
		return Bouton_Save.partie;
	}
	
	public static void setPartieCourante(PartieCourante particeCourante) {
		partie = particeCourante;
	}
	
	@Override
	public void executer() {
        //Save de la partie
		if (partie == null) {
			JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
				"Aucune partie en cours, sauvegarde échouée");
		} else {
			Sauvegarder.creerSauvegarde(partie);
			JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
				"La ville a bien été sauvegardée");
		}
		
	}

	@Override
	public String getNom() {
		return "Sauvegarder";
	}	
}
