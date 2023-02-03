package src.menus.fenetre_nomPartie;

import src.menus.boutons.*;
import src.PartieCourante;
import src.menus.Menu;

import javax.swing.*;
import java.awt.*;
import java.io.*;
import javax.imageio.*;

@SuppressWarnings("serial")
public class NomPartie extends JPanel {

    private Bouton_ValiderLancement lancer;
    private JFrame fenetreActuelle, fenetrePrincipale;
    private Menu menuLancement;
    private JTextField nom;

    public NomPartie(Menu menuLancement, JFrame fenetrePrincipale, JFrame fenetreActuelle) {
        super();
        this.setLayout(null);

        this.menuLancement = menuLancement;
        this.fenetrePrincipale = fenetrePrincipale;
        this.fenetreActuelle = fenetreActuelle;

        this.lancer = new Bouton_ValiderLancement(this);
        

        this.nom = new JTextField();
        this.nom.setEditable(true);       
        this.nom.setOpaque(false);
        this.nom.setForeground(Color.WHITE);
        this.nom.setFont(new Font("Arial", Font.BOLD, 30));
        


        this.add(this.lancer);
        this.add(this.nom);

        this.setVisible(true);

    }

    public void updatePosition() {
        this.lancer.setBounds(525*this.getWidth()/1920, 265*this.getHeight()/1080, 
            922*this.getWidth()/1920, 175*this.getHeight()/1080);

        this.nom.setBounds(670*this.getWidth()/1920, 610*this.getHeight()/1080, 
            941*this.getWidth()/1920, 180*this.getHeight()/1080);

            //Mise de la taille de text
        this.nom.setFont(new Font(this.nom.getFont().getName(), Font.BOLD,  9*this.nom.getHeight()/10));
    }

    public void launch() {
        if(this.nom.getText().length() != 0 ) {
            PartieCourante partie = new PartieCourante(nom.getText());
            Bouton_Save.setPartieCourante(partie);
            PartieCourante.setPause(false);
            this.menuLancement.effacer();
            this.fenetreActuelle.dispose();
            partie.afficher(this.fenetrePrincipale);            
        } else {
            JOptionPane.showMessageDialog(this.fenetreActuelle.getContentPane(), 
				"Merci de rentrer un nom pour la partie que vous voulez créer");
	    }
        
    }

    public void paintComponent(Graphics g)
    {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgprinc = ImageIO.read(new File("src/Images/Fond_Nom_Partie.png"));
            g.drawImage(imgprinc, 0, 0, this.getWidth(), this.getHeight(), this);
        } catch (IOException e) {
            System.out.println("Erreur image de fond principal : " + e.getMessage());
        }
    }
}