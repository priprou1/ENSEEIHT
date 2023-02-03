package src;

import java.awt.*;
import javax.swing.*;

import src.carte.Case;

public abstract class Structure {

	private Image image;
	private String nomStructure;
	private int tailleStructure = 1;
	
	public static final int longueurCase = 52; 
	
	public Structure() {
		//chemin = "src/Images/Routes/Route_trottoir" + nomStructure + ".png";
		this.setNomStructure();
		this.setImageBatiment();
	}

	public void afficher(Graphics g, int xFond, int yFond) {
		Case coin = this.getCoin();
		g.drawImage(this.image, xFond + coin.getX()*longueurCase, yFond + coin.getY()*longueurCase, null);
	}

	public void setImageBatiment() {
		String chemin = "src/Images/img_" + nomStructure + ".png";
		ImageIcon icon = new ImageIcon(chemin);
		this.image = icon.getImage();
	}
	
	
	public void setImageRoute(String chemin) {
		ImageIcon icon = new ImageIcon(chemin);
		this.image = icon.getImage();
	}
	
	public Image getImage() {
		return this.image;
	}
	
	public void setTailleStructure(int taille) {
		this.tailleStructure = taille;
		this.image = image.getScaledInstance(longueurCase*this.tailleStructure, longueurCase*this.tailleStructure, Image.SCALE_DEFAULT);
	}
	
	public String getNomStructure() {
		return this.nomStructure;
	}
	
	
	public void setNomStructure() {
		this.nomStructure = this.getClass().getSimpleName();
	}
	
	
	public abstract Case[] getCases();

	public abstract Case getCoin();

	public abstract void setCoin(Case coin);
	
}
