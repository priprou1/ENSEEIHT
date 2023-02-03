package src.menus.boutons;

import javax.swing.*;

@SuppressWarnings("serial")
public class Bouton_Racourcis extends Boutons {
	private JFrame fenetre;
	
	public Bouton_Racourcis(JFrame fenetre) {
		super();
		this.fenetre = fenetre;
		
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		
		this.addActionListener(this);		
	}
	
	@Override
	public void executer() {
		JOptionPane.showMessageDialog(this.fenetre.getContentPane(), 
				"Ne sera pas développée avant la fin du projet");
	}

	@Override
	public String getNom() {
		return "Racourcis clavier";
	}
}
