package src.affichagePartie.affichageChoixAction;

import src.affichagePartie.*;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.IOException;

@SuppressWarnings("serial")
public class CaseSelectionnables extends JPanel implements MouseListener {

    private ImageIcon iconInitiale;
    private JLabel icon;
    private ResizeFontLabel nom;
    private Image imgplay;
    private Image imgselected;
    private Boolean selectionne;
    private Boolean parcelles; // Savoir si c'est l'affichage d'une parcelle 
    private JLabel[] textparcelle = new JLabel[3];
    private int parcelleSelected = 0;


    public CaseSelectionnables() {
        super();
        this.setLayout(new GridLayout(2,1));

        try {
            this.imgplay = ImageIO.read(new File("src/Images/FondBoutonAction.png"));
        } catch (IOException e) {
            System.out.println("Erreur image de fond case action : " + e.getMessage());
        }
        try {
            this.imgselected = ImageIO.read(new File("src/Images/FondBoutonActionSelection.png"));
        } catch (IOException e) {
            System.out.println("Erreur image de fond case action selectionnée : " + e.getMessage());
        }
        this.selectionne = false;

        icon = new JLabel();
        icon.setHorizontalAlignment(SwingConstants.CENTER);
        icon.setVerticalAlignment(SwingConstants.CENTER);

        nom = new ResizeFontLabel("");
        nom.setOpaque(false);
        nom.setHorizontalAlignment(SwingConstants.CENTER);
        nom.setVerticalAlignment(SwingConstants.TOP);

        textparcelle[0] = new JLabel("Taille 1x1");
        textparcelle[1] = new JLabel("Taille 2x2");
        textparcelle[2] = new JLabel("Taille 3x3");

        this.add(icon);
        this.add(nom);
        

    }

    public void setLabelIcon(Icon icon) {
        this.iconInitiale = (ImageIcon) icon;
        this.icon.setIcon(icon);
    }

    public void setTextArea(String text) {
        this.nom.setText(text);
    }
    
    public void updatePosition() {
        this.updateImage();
    }

    public void setSelected(Boolean selection) {
        this.selectionne = selection;
        this.repaint();
    }
    
    public void setParcelles(Boolean choix) {
        this.parcelles = choix;

        if(this.parcelles) {
            this.remove(icon);
            this.remove(nom);

            this.setLayout(new GridLayout(4, 1));
            
            for(int i = 0; i < 3; i++) {
                textparcelle[i].addMouseListener(this);
                textparcelle[i].setHorizontalAlignment(SwingConstants.CENTER);
                textparcelle[i].setVerticalAlignment(SwingConstants.CENTER);
                this.setOpaque(false);
                this.setForeground(Color.BLACK);
                this.add(textparcelle[i]);
            }
            
            textparcelle[parcelleSelected].setForeground(Color.WHITE);
        } else {
            for(int i = 0; i < 3; i++) {
                textparcelle[i].removeMouseListener(this);
                this.remove(textparcelle[i]);
            }
            this.setLayout(new GridLayout(2,1));

            this.add(icon);
            this.add(nom);
        }
    }


    private void updateImage() {
        try {
            this.icon.setIcon(this.resizeSquareIcon(this.iconInitiale, this.icon));
        } catch (Exception e) {
            
        }
    }

    private ImageIcon resizeSquareIcon(ImageIcon icon, JLabel label) {
        int taille = Math.min(label.getWidth(), label.getHeight());
        return new ImageIcon(icon.getImage().getScaledInstance(taille, taille, Image.SCALE_DEFAULT));
    }

    public void paintComponent(Graphics g) {
        //Chargement de l"image de fond
     	super.paintComponent(g);
        if (this.selectionne) {
            g.drawImage(this.imgselected, 0, 0, this.getWidth(), this.getHeight(), this);
        } else {
            g.drawImage(this.imgplay, 0, 0, this.getWidth(), this.getHeight(), this);
        }
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        if(parcelles) {
            for(int i = 0; i < 3; i++) {
                if(e.getSource() == textparcelle[i]) {
                    parcelleSelected = i;
                    textparcelle[i].setForeground(Color.WHITE);
                    SelectionAction.setParcelles(i + 1);
                } else {
                    textparcelle[i].setForeground(Color.BLACK);
                }
            }
        }
    }

    @Override
    public void mouseEntered(MouseEvent e) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void mouseExited(MouseEvent e) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void mousePressed(MouseEvent e) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void mouseReleased(MouseEvent e) {
        // TODO Auto-generated method stub
        
    }
}
