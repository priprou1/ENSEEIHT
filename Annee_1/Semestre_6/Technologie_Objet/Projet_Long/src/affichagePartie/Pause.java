package src.affichagePartie;

import src.menus.boutons.*;

import javax.swing.*;
import java.awt.*;

@SuppressWarnings("serial")
public class Pause extends JPanel {
    
    private Bouton_Pause pauseButton;

    public Pause(Bouton_Pause pause) {
        super();
        this.setLayout(null);
        this.setBackground(Color.WHITE);

        this.pauseButton = pause;

        this.add(pauseButton);

        this.setVisible(true);
    }

    public void updatePosition() {

        pauseButton.setBounds(0, 0, this.getWidth(),  this.getHeight());

    }
}
