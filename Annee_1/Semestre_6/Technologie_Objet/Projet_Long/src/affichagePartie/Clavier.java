package src.affichagePartie;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

public class Clavier implements KeyListener {
	
	public final static int deplacementElementaire = -16;
	@Override
	public void keyPressed(KeyEvent e) {
		
		if(e.getKeyCode() == KeyEvent.VK_RIGHT) {
		//	AffichagePartie.affichageCarte.setDx(deplacementElementaire);
		} else if (e.getKeyCode() == KeyEvent.VK_LEFT) {
		//	AffichagePartie.affichageCarte.setDx(-deplacementElementaire);
		} else if (e.getKeyCode() == KeyEvent.VK_UP) {
		//	AffichagePartie.affichageCarte.setDy(-deplacementElementaire);
		} else if (e.getKeyCode() == KeyEvent.VK_DOWN) {
		//	AffichagePartie.affichageCarte.setDy(deplacementElementaire);
		}
		System.out.println("aaa");
		try
		{
		    Thread.sleep(5);
		}
		catch(InterruptedException ex)
		{
		    Thread.currentThread().interrupt();
		}
		
		//AffichagePartie.affichageCarte.repaint();
		
	}

	@Override
	public void keyReleased(KeyEvent arg0) {
		//AffichagePartie.affichageCarte.setDx(0);
		//AffichagePartie.affichageCarte.setDy(0);
	}

	@Override
	public void keyTyped(KeyEvent arg0) {}

}
