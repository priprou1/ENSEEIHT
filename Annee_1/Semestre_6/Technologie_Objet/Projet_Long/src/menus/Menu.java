package src.menus;

import java.awt.Dimension;
import java.awt.event.*;

import javax.swing.*;

@SuppressWarnings("serial")
public abstract class Menu extends JPanel implements ComponentListener {
	private JFrame fenetre;
	
	public Menu(JFrame fenetre) {
		super();
		this.fenetre = fenetre;
	}
	
	public void afficher() {
		this.setVisible(true);
		
	}
	
	public void effacer() {
		this.setVisible(false);
		Dimension d = fenetre.getSize();
		fenetre.setSize(0, 0);
		fenetre.setSize(d);
	}	
	
	@Override
	public abstract void componentResized(ComponentEvent e);
	
	@Override
	public void componentHidden(ComponentEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void componentMoved(ComponentEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void componentShown(ComponentEvent arg0) {
		// TODO Auto-generated method stub
		
	}
}
