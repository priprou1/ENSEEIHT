package src.menus;

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.imageio.*;
import javax.swing.*;

import src.affichagePartie.AffichagePartie;
import src.menus.boutons.*;

//import src.PartieCourante;
@SuppressWarnings("serial")
public class MenuPause extends Menu {

	
	private JFrame fenetre;	
	private Boutons reprendre, save, parametre, quitter;
	//private PartieCourante partie;

	
	public MenuPause(JFrame fenetre, AffichagePartie partie) {
		super(fenetre);
		this.fenetre = fenetre;
		//this.partie = partie;

		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight());
		this.setLayout(null);
		
		this.reprendre = new Bouton_Reprendre(this, partie);
		this.save = new Bouton_Save(this.fenetre);
		this.parametre = new Bouton_Parametre(this.fenetre, this);
		this.quitter = new Bouton_Retour(new MenuPrincipal(this.fenetre), this);

		this.add(this.reprendre);
		this.add(this.save);
		this.add(this.parametre);
		this.add(this.quitter);
		
		this.fenetre.getContentPane().add(this);
		this.fenetre.addComponentListener(this);
		this.setVisible(false);

	}
	
	@Override
	public void componentResized(ComponentEvent e) {
		
		this.setBounds(0, 0, this.fenetre.getWidth(), this.fenetre.getHeight()); 
		
		int largeur = 461*this.getWidth()/960;
		int hauteur = 87*this.getHeight()/540;
		int align_gauche = 250*this.getWidth()/960;
		
		this.reprendre.setBounds(align_gauche, 52*this.getHeight()/540, largeur, hauteur);
		this.save.setBounds(align_gauche, 169*this.getHeight()/540, largeur, hauteur);
		this.parametre.setBounds(align_gauche, 285*this.getHeight()/540, largeur, hauteur);
		this.quitter.setBounds(align_gauche, 401*this.getHeight()/540, largeur, hauteur);    
	}
	
	public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgparam = ImageIO.read(new File("src/Images/Fond_Menu_Pause.png"));
            g.drawImage(imgparam, 0, 0, this.fenetre.getWidth(), this.fenetre.getHeight(), this);
        } catch (IOException e) {
            System.out.println("Erreur image de fond pause : " + e.getMessage());
        }
    }
}
