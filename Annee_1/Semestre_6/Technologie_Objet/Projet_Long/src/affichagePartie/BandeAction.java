package src.affichagePartie;

import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.*;

import src.affichagePartie.affichageChoixAction.CaseSelectionnables;

@SuppressWarnings("serial")
public class BandeAction extends JPanel implements MouseListener {
    private JFrame fenetre;
    //On a 8 type de batiments, un bouton route et un bouton detruire puis il y aura 
    // les differentes variante sur les cases qui suivent (5 variantes maximales)
    private final static int nbBoutons = 18;
    private final static int nbBatiment = 13;

    private CaseSelectionnables[] caseSelectionnables  = new CaseSelectionnables[nbBoutons];
    private static Icon[] iconBatiment = new Icon[nbBatiment];
    private static Icon[] iconNiveau = new Icon[4];
    private static Icon[][] iconRoutes = new Icon[5][4];
    private int[] rotationRoute = {0, 0, 0, 0, 0};
    private int selected = -1; //type de batiment selectionné
    private int optionSelected = -1; //Cases optionnelles selectionné (de 10 à 14)
    
    static {
        iconBatiment[0] = new ImageIcon("src/Images/Icones_BandeAction/img_Habitation.png", "Habitation");
        iconBatiment[1] = new ImageIcon("src/Images/Icones_BandeAction/img_Commerce.png", "Commerce");
        iconBatiment[2] = new ImageIcon("src/Images/Icones_BandeAction/img_Industrie.png", "Industrie");
        iconBatiment[3] = new ImageIcon("src/Images/Icones_BandeAction/img_Usine.png", "Usine");
        iconBatiment[4] = new ImageIcon("src/Images/Icones_BandeAction/img_Police.png", "Police");
        iconBatiment[5] = new ImageIcon("src/Images/Icones_BandeAction/img_Pompier.png", "Pompiers");
        iconBatiment[6] = new ImageIcon("src/Images/Icones_BandeAction/img_Hopital.png", "Hôpital");
        iconBatiment[7] = new ImageIcon("src/Images/Icones_BandeAction/img_Mairie.png", "Mairie");
        iconBatiment[8] = new ImageIcon("src/Images/Icones_BandeAction/img_Ecole.png", "Ecole");
        iconBatiment[9] = new ImageIcon("src/Images/Icones_BandeAction/img_PoleEmploi.png", "Pole-Emploi");
        iconBatiment[10] = new ImageIcon("src/Images/Icones_BandeAction/img_Hotel.png", "Hotel");
        iconBatiment[11] = new ImageIcon("src/Images/Icones_BandeAction/Route_trottoir21.png", "Routes");
        iconBatiment[12] = new ImageIcon("src/Images/Icones_BandeAction/bombe.png", "Detruire");

        // Routes
        for(int i = 0; i < 5; i++) {
            if(i == 0 || i == 2 || i == 4){
                for (int j = 0; j < 4; j++) {
                    iconRoutes[i][j] = new ImageIcon("src/Images/Icones_BandeAction/Route_trottoir"+ (i+1) + (j+1) +".png", "Routes " + (i+1));
                }
            } else if (i == 1) {
                for (int j = 0; j < 2; j++) {
                    iconRoutes[i][j] = new ImageIcon("src/Images/Icones_BandeAction/Route_trottoir"+ (i+1) + (j+1) +".png", "Routes " + (i+1));
                    iconRoutes[i][j+2] = new ImageIcon("src/Images/Icones_BandeAction/Route_trottoir"+ (i+1) + (j+1) +".png", "Routes " + (i+1));
                }
            } else {
                for (int j = 0; j < 4; j++) {
                    iconRoutes[i][j] = new ImageIcon("src/Images/Icones_BandeAction/Route_trottoir"+ (i+1) + "1.png", "Routes " + (i+1));
                }
            }
        }

        

        for(int i = 0; i < 4; i++) {
            iconNiveau[i] = new ImageIcon("src/Images/Icon_Niveau/" + (i+1) +".png", "Niveau" + (i+1));
        }  
        
    }
    public BandeAction(JFrame fenetre) {
        super();
        this.fenetre = fenetre;
        this.setLayout(new GridLayout(1, nbBoutons));

        for (int i = 0; i < nbBatiment; i ++) {
            caseSelectionnables[i] = new CaseSelectionnables();
            caseSelectionnables[i].setLabelIcon(iconBatiment[i]);
            caseSelectionnables[i].setTextArea(iconBatiment[i].toString());
            caseSelectionnables[i].addMouseListener(this);

            this.add(this.caseSelectionnables[i]);
        }
        
        for (int i = nbBatiment; i < nbBoutons; i ++) {
            caseSelectionnables[i] = new CaseSelectionnables();
            caseSelectionnables[i].addMouseListener(this);

            this.add(this.caseSelectionnables[i]);
        }

        this.fenetre.getContentPane().add(this);

		this.setVisible(true);
        this.effacerBoutonsOptions();
    }

    public void updatePosition() {
        if(this.getHeight() != 0 && this.getWidth() != 0) {
            for(int i = 0; i < nbBoutons; i++) {
                this.caseSelectionnables[i].updatePosition();
            }
        } else if (this.getHeight() == 0) {
            System.out.println("Hauteur de Bande action nulle");
        } else {
            System.out.println("Largeur de Bande Action nulle");
        }
        
    }

    public void effacerBoutonsOptions() {
        for(int i = nbBatiment; i < nbBoutons; i++) {
            caseSelectionnables[i].setVisible(false);
        }     
        this.caseSelectionnables[nbBoutons - 1].setParcelles(false);  
    }

    public void afficherNiveau(String typeBatiment, int nbDeNiveau){
        for(int i = 0; i < Math.min(4, nbDeNiveau); i++) {
            this.caseSelectionnables[i + nbBatiment].setVisible(true);
            this.caseSelectionnables[i + nbBatiment].setTextArea(iconNiveau[i].toString());
            this.caseSelectionnables[i + nbBatiment].setLabelIcon(iconNiveau[i]);
        }

        this.caseSelectionnables[nbBoutons - 1].setVisible(true);
        this.caseSelectionnables[nbBoutons - 1].setParcelles(true);
    }

    public void afficherRoutes(){
        this.caseSelectionnables[nbBoutons - 1].setParcelles(false);  
        for(int i = 0; i < 5; i++) {
            this.caseSelectionnables[i + nbBatiment].setVisible(true);
            this.caseSelectionnables[i + nbBatiment].setTextArea(iconRoutes[i][rotationRoute[i]].toString());
            this.caseSelectionnables[i + nbBatiment].setLabelIcon(iconRoutes[i][rotationRoute[i]]);
        }
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        int deselection = this.selected;
        int deselectionOption = this.optionSelected;
       
        for(int i = 0; i < nbBoutons; i++) {
            if (e.getSource() == this.caseSelectionnables[i]) {
                this.caseSelectionnables[i].setOpaque(true);
                this.caseSelectionnables[i].setSelected(true);
                // On regarde si on click sur une option ou un type de batiment
                if(i < nbBatiment) {

                    this.selected = i;
                    effacerBoutonsOptions();
                    
                    //Batiment avec niveau
                    if (i < nbBatiment - 2) {
                        this.afficherNiveau(iconBatiment[i].toString(), 3);
                    }
                    
                    //Routes
                    if (i == nbBatiment - 2) {
                        this.afficherRoutes();                        
                    }

                    if (i == nbBatiment -1) {
                        SelectionAction.setDetruire(true);
                    } else {
                        SelectionAction.setDetruire(false);
                        SelectionAction.setNomBatiment(iconBatiment[i].toString());
                        SelectionAction.setNiveau(-1);
                    }


                } else if(i != (nbBoutons - 1) || selected == (nbBatiment - 2)){
                    
                    this.optionSelected = i;
                    SelectionAction.setNiveau(i - nbBoutons + 1 + 5);  ////////////////

                    if (SwingUtilities.isRightMouseButton(e) && selected == (nbBatiment - 2)) {
                        int nbRoute =  i - nbBatiment;
                        System.out.println("Rotation route " + (nbRoute + 1));
                        if (rotationRoute[nbRoute] < 3) {
                            rotationRoute[nbRoute] += 1;
                        } else {
                            rotationRoute[nbRoute] = 0;
                        }
                        
                        this.caseSelectionnables[i].setLabelIcon(iconRoutes[nbRoute][rotationRoute[nbRoute]]);
                        SelectionAction.setRotation(rotationRoute[nbRoute]);
                    } else if (selected == (nbBatiment - 2)) {
                        SelectionAction.setRotation(rotationRoute[i - nbBatiment]);
                    }
                    
                }                   
            }
        }             

        if(this.selected != deselection && deselection != -1) {
            this.caseSelectionnables[deselection].setBackground(Color.WHITE);
            this.caseSelectionnables[deselection].setOpaque(false);
            this.caseSelectionnables[deselection].setSelected(false);

            if(this.optionSelected != -1) {
                this.caseSelectionnables[this.optionSelected].setBackground(Color.WHITE);
                this.caseSelectionnables[this.optionSelected].setOpaque(false);
                this.caseSelectionnables[this.optionSelected].setSelected(false);
                this.optionSelected = -1;
            }
        } else if (this.optionSelected != deselectionOption && deselectionOption != -1) {
            this.caseSelectionnables[deselectionOption].setBackground(Color.WHITE);
            this.caseSelectionnables[deselectionOption].setOpaque(false);
            this.caseSelectionnables[deselectionOption].setSelected(false);
        }
    }

    public void paintComponent(Graphics g) {
        //Chargement de l"image de fond
        try {
        	super.paintComponent(g);
            Image imgplay = ImageIO.read(new File("src/Images/FondBandeauAction.png"));
            g.drawImage(imgplay, 0, 0, this.getWidth(), this.getHeight(), this);
        } catch (IOException e) {
            System.out.println("Erreur image de fond bande action : " + e.getMessage());
        }
    }

    @Override
    public void mousePressed(MouseEvent e) {}

    @Override
    public void mouseReleased(MouseEvent e) {}

    @Override
    public void mouseEntered(MouseEvent e) {}

    @Override
    public void mouseExited(MouseEvent e) {}


}
