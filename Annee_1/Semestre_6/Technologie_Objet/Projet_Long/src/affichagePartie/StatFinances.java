package src.affichagePartie;

import javax.swing.*;
import java.awt.*;

@SuppressWarnings("serial")
public class StatFinances extends JPanel {
    private static JLabel energieIcon, argentIcon;
    private static ResizeFontLabel titre, energieValue, argent;

    public StatFinances() {
        super();
        this.setLayout(null);
        this.setOpaque(false);

        energieIcon = new JLabel();        
        energieIcon.setIcon(new ImageIcon("src/Images/Icones_Stats/energie.png"));
        energieIcon.setVerticalAlignment(SwingConstants.BOTTOM);
        energieIcon.setHorizontalAlignment(SwingConstants.CENTER);
        argentIcon = new JLabel();
        argentIcon.setIcon(new ImageIcon("src/Images/Icones_Stats/argent.png"));
        argentIcon.setVerticalAlignment(SwingConstants.BOTTOM);
        argentIcon.setHorizontalAlignment(SwingConstants.CENTER);
        titre = new ResizeFontLabel("Finances");
        energieValue = new ResizeFontLabel("");
        argent = new ResizeFontLabel("");

        titre.setHorizontalAlignment(SwingConstants.CENTER);
        energieValue.setHorizontalAlignment(SwingConstants.CENTER);
        argent.setHorizontalAlignment(SwingConstants.CENTER);
        
        this.add(energieIcon);
        this.add(argentIcon);
        this.add(argent);
        this.add(energieValue);
        this.add(titre);

        
        updateArgent(100000);
        updateEnergie(100);
        this.setVisible(true);
    }

    // Cela permets d'update les valeur d'energie et d'argent sans créer une instance de statFinances. Donc on peut mettre à jour cette valeur depuis une autre classe sans créer de nouvel objet statFinances.
    public static void updateEnergie(int value) {
        if (energieValue != null) energieValue.setText(value + " %");
    }

    public static void updateArgent(int value) {
    	if (argent != null) argent.setText("" + value);
    }

    public void updatePosition() {
        titre.setBounds(0, 0, this.getWidth(),  3*this.getHeight()/10);

        argentIcon.setBounds(0,  3*this.getHeight()/10, this.getWidth()/2, 7*this.getHeight()/20);

        argent.setBounds(0,  14*this.getHeight()/20, this.getWidth()/2, this.getHeight()/5);

        energieIcon.setBounds(this.getWidth()/2,  3*this.getHeight()/10, this.getWidth()/2, 7*this.getHeight()/20);

        energieValue.setBounds(this.getWidth()/2,  14*this.getHeight()/20, this.getWidth()/2, 1*this.getHeight()/5);   
        
        this.updateImage();
        
        titre.updateFont();
        argent.updateFont();
        energieValue.updateFont();
    }

    public void updateImage() {        
        energieIcon.setIcon(resizeSquareIcon((ImageIcon) energieIcon.getIcon(), energieIcon));
        argentIcon.setIcon(resizeSquareIcon((ImageIcon) argentIcon.getIcon(), argentIcon));
    }

    private ImageIcon resizeSquareIcon(ImageIcon icon, JLabel label) {
        int taille = Math.min(label.getWidth(), label.getHeight()); 
        if(taille == 0) {
            return icon;
        }
        return new ImageIcon(icon.getImage().getScaledInstance(taille, taille, Image.SCALE_DEFAULT));
    }
}
