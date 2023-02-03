package src.affichagePartie;

import javax.swing.*;

@SuppressWarnings("serial")
public class Affichage_annonces extends JPanel {
    private ResizeFontLabel titre;
    private static ResizeFontTextArea annonces;

    public Affichage_annonces() {
        super();
        this.setLayout(null);

        this.titre = new ResizeFontLabel("Annonces");
        this.titre.setHorizontalAlignment(SwingConstants.CENTER);
        
        annonces = new ResizeFontTextArea("");
        annonces.setRows(2);
        annonces.setColumns(1);
        annonces.setOpaque(false);
        annonces.setEditable(false);
        this.add(this.titre);
        this.add(annonces);
        
        this.setOpaque(false);
        this.setVisible(true);
        
        Affichage_annonces.addAnnonce("Aucune annonce disponible\n");
    }

    // Cela permets d'update le titre de la partie et l'heure sans devoir créer d'instance dans la classe appelante.
    public static void addAnnonce(String newannonce) {
        annonces.setText("");
        annonces.append(newannonce);
    }

    public void updatePosition() {
        this.titre.setBounds(0, this.getHeight()/20, this.getWidth(), this.getHeight()/4);
        annonces.setBounds(this.getWidth()/20, 6*this.getHeight()/20, 9*this.getWidth()/10, 11*this.getHeight()/20);

        titre.updateFont();
        annonces.updateFont();
    }
}
