package src.menus.boutons;

import javax.swing.*;
import java.awt.geom.*;
import java.awt.*;

@SuppressWarnings("serial")
public class Bouton_Resolution extends Boutons {

	private JFrame fenetre;
	private int largeur, hauteur;
	
	public Bouton_Resolution(JFrame fenetre, int largeur, int hauteur) {
		super();
		this.fenetre = fenetre;
		
		this.largeur = largeur;
		this.hauteur = hauteur;
		//this.setText(this.getNom());
		//this.setFont(new Font("Arial", Font.BOLD, 30));
		//this.setForeground(Color.BLACK);
		
		this.setOpaque(false);
		this.setContentAreaFilled(false);
		this.addActionListener(this);
		
	}
	
	@Override
	public void executer() {
		this.fenetre.setSize(this.largeur, this.hauteur);
		this.fenetre.setLocationRelativeTo(null);

	}

	@Override
	public String getNom() {
		return "Reoslution " + this.largeur + "x" + this.hauteur;
	}	

	/*protected void paintComponent(Graphics g) {
		if (getModel().isArmed()) {		
			g.setColor(Color.lightGray);
		} else {
			g.setColor(getBackground());
		}

		//g.fillOval(0, 0, getSize().width-1, getSize().height-1);
		super.paintComponent(g);
	}*/

	protected void paintBorder(Graphics g) {
		
		if (getModel().isArmed()) {		
			g.setColor(Color.WHITE);
		} else {
			g.setColor(Color.LIGHT_GRAY);
		}
		g.drawOval(0, 0, getSize().width-1, getSize().height-1);
	}
	
	Shape shape;
	public boolean contains(int x, int y) {
		if (shape == null || !shape.getBounds().equals(getBounds())) {
			shape = new Ellipse2D.Float(0, 0, this.getWidth(), this.getHeight());
		}
		return shape.contains(x, y);
	}
}
