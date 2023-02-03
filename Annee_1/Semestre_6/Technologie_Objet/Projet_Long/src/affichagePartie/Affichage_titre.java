package src.affichagePartie;

import javax.swing.*;

@SuppressWarnings("serial")
public class Affichage_titre extends JPanel {
    private static ResizeFontLabel name, day, time;

    public Affichage_titre() {
        super();
        this.setLayout(null);
        this.setOpaque(false);

        name = new ResizeFontLabel("Nom Partie");
        day = new ResizeFontLabel("1 janvier 2000");
        time = new ResizeFontLabel("00 : 00");

        name.setHorizontalAlignment(SwingConstants.CENTER);
        day.setHorizontalAlignment(SwingConstants.CENTER);
        time.setHorizontalAlignment(SwingConstants.CENTER);

        this.add(name);
        this.add(day);
        this.add(time);
        
        this.setVisible(true);
    }

    // Cela permets d'update le titre de la partie et l'heure sans devoir créer d'instance dans la classe appelante.
    public static void updateTitle(String nomPartie) {
        if (name != null) name.setText(nomPartie);
    }

    public static void updateDay(String date) {
    	if (day != null) day.setText(date);
    }

    public static void updateTime(String horaire) {
    	if (time != null) time.setText(horaire);
    }

    public void updatePosition() {
        name.setBounds(0, 1*this.getHeight()/20, this.getWidth(), 1*this.getHeight()/2);
        day.setBounds(0, 11*this.getHeight()/20, this.getWidth()/2, 7*this.getHeight()/20);
        time.setBounds(this.getWidth()/2, 11*this.getHeight()/20, this.getWidth()/2, 7*this.getHeight()/20);

        

        name.updateFont();
        day.updateFont();
        time.updateFont();
    }
}
