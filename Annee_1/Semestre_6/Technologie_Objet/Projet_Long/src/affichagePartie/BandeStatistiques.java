package src.affichagePartie;

import src.menus.boutons.*;

import java.io.*;
import javax.imageio.*;
import javax.swing.*;
import java.awt.*;

@SuppressWarnings("serial")

public class BandeStatistiques extends JPanel {

    private JFrame fenetre;

    private Affichage_annonces annonces;
    private StatHabitants statHabitants;
    private StatFinances statFinances;
    private Affichage_titre titre;
    private Bouton_Pause pause;

    public BandeStatistiques(JFrame fenetre, AffichagePartie partie) {
        super();
        this.fenetre = fenetre;

		this.setLayout(null);

        this.statHabitants = new StatHabitants();
        this.statFinances = new StatFinances();
        this.titre = new Affichage_titre();
        this.annonces = new Affichage_annonces();
        this.pause = new Bouton_Pause(this.fenetre, partie);        

        this.add(this.statHabitants);
        this.add(this.statFinances);
        this.add(this.titre);
        this.add(this.annonces);
        this.add(this.pause);

        this.fenetre.getContentPane().add(this);

		this.setVisible(true);
    }

    public void pause() {
        this.setVisible(false);
    }
 

    void updatePosition() {
        int poslartitre = 27*this.getWidth()/80;
        int pos_hauteur = this.getHeight()/20;
        int largeurtitre = this.getWidth()/3;
        int hauteur = 9*this.getHeight()/10;
        this.titre.setBounds(poslartitre, pos_hauteur, largeurtitre, hauteur);

        int largeurstat = 3*this.getWidth()/20;
        this.statFinances.setBounds(this.getWidth()/80, pos_hauteur, largeurstat, hauteur);
        this.statHabitants.setBounds(7*this.getWidth()/40, pos_hauteur, largeurstat, hauteur);

        this.annonces.setBounds(41*this.getWidth()/60, pos_hauteur, this.getWidth()/4, hauteur);
        this.pause.setBounds(113*this.getWidth()/120, 1*this.getHeight()/10, 4*this.getHeight()/5, 4*this.getHeight()/5);

        this.statHabitants.updatePosition();        
        this.statFinances.updatePosition();
        this.titre.updatePosition();
        this.annonces.updatePosition();
    }

    
    public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgplay = ImageIO.read(new File("src/Images/bandeauStat.png"));
            g.drawImage(imgplay, 0, 0, this.getWidth(), this.getHeight(), this);
        } catch (IOException e) {
            System.out.println("Erreur image de fond bande stat : " + e.getMessage());
        }
    }
}
