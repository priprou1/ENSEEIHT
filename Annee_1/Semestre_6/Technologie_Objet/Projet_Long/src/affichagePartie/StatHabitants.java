package src.affichagePartie;

import javax.swing.*;
import java.awt.*;

@SuppressWarnings("serial")
public class StatHabitants extends JPanel {
    private static JLabel bonheurIcon, bonhommeIcon;
    private static ResizeFontLabel titre, bonheurValue, nbhabitant;

    public StatHabitants() {
        super();
        this.setLayout(null);
        this.setOpaque(false);

        bonheurIcon = new JLabel();        
        bonheurIcon.setVerticalAlignment(SwingConstants.CENTER);
        bonheurIcon.setHorizontalAlignment(SwingConstants.CENTER);
        bonhommeIcon = new JLabel();
        bonhommeIcon.setVerticalAlignment(SwingConstants.CENTER);
        bonhommeIcon.setHorizontalAlignment(SwingConstants.CENTER);
        bonhommeIcon.setIcon(new ImageIcon("src/Images/Icones_Stats/bonhomme.png"));
        titre = new ResizeFontLabel("Habitants");
        bonheurValue = new ResizeFontLabel("");
        nbhabitant = new ResizeFontLabel("");

        titre.setHorizontalAlignment(SwingConstants.CENTER);       
        bonheurValue.setHorizontalAlignment(SwingConstants.CENTER);
        nbhabitant.setHorizontalAlignment(SwingConstants.CENTER);

        
        this.add(bonheurIcon);
        this.add(bonhommeIcon);
        this.add(titre);
        this.add(bonheurValue);
        this.add(nbhabitant);

        updateBonheur(100);
        updatePopulation(100);

        this.setVisible(true);
    }

    // Cela permets d'update les valeur de bonheur et du nombre d'habitant sans créer une instance de stathabitants.

    public static void updateBonheur(double value) {
        if (bonheurValue != null) {
    		bonheurValue.setText(value + " %");
        	if(value > 80) {
        		bonheurIcon.setIcon(new ImageIcon("src/Images/Icones_Stats/heureux.png"));
        	} else if(value > 60) {
        		bonheurIcon.setIcon(new ImageIcon("src/Images/Icones_Stats/content.png"));
        	} else if(value > 40) {
        		bonheurIcon.setIcon(new ImageIcon("src/Images/Icones_Stats/pascontent.png"));
        	} else {
        		bonheurIcon.setIcon(new ImageIcon("src/Images/Icones_Stats/triste.png"));
        	}
        	updateImage();
    	}
    }

    public static void updatePopulation(int nb_habitant) {
        if (nbhabitant != null) nbhabitant.setText("" + nb_habitant);
    }

    void updatePosition() {

        titre.setBounds(0, 0, this.getWidth(),  3*this.getHeight()/10);

        bonhommeIcon.setBounds(0,  3*this.getHeight()/10, this.getWidth()/2, 8*this.getHeight()/20);

        nbhabitant.setBounds(0, 14*this.getHeight()/20, this.getWidth()/2, this.getHeight()/5);

        bonheurIcon.setBounds(this.getWidth()/2,  3*this.getHeight()/10, this.getWidth()/2, 8*this.getHeight()/20);

        bonheurValue.setBounds(this.getWidth()/2,  14*this.getHeight()/20, this.getWidth()/2, this.getHeight()/5);   
            
        updateImage();

        titre.updateFont();
        bonheurValue.updateFont();
        nbhabitant.updateFont();
    }

    public static void updateImage() {        
        bonheurIcon.setIcon(resizeSquareIcon((ImageIcon) bonheurIcon.getIcon(), bonheurIcon));
        bonhommeIcon.setIcon(resizeSquareIcon((ImageIcon) bonhommeIcon.getIcon(), bonhommeIcon));
    }

    private static ImageIcon resizeSquareIcon(ImageIcon icon, JLabel label) {
        try {
            int taille = Math.min(label.getWidth(), label.getHeight()); 
            if(taille == 0) {
                return icon;
            }
            return new ImageIcon(icon.getImage().getScaledInstance(taille, taille, Image.SCALE_SMOOTH));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return icon;
    }
}
