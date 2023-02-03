package src.menus.boutons;

import javax.swing.*;

@SuppressWarnings("serial")
public class Bouton_Scenario extends Boutons {
	
	private JFrame fenetre;
	
	public Bouton_Scenario(JFrame fenetre) {
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
				"En cours de developpement");
	}

	@Override
	public String getNom() {
		return "Scénarios";
	}

}
