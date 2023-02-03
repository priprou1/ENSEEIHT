package src.menus.boutons;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;

@SuppressWarnings("serial")
public abstract class Boutons extends JButton implements ActionListener {
		
	public Boutons() {
		super();
		this.setVisible(true);
	}

	public abstract void executer();
	
	public abstract String getNom();
	
	@Override
	public void actionPerformed(ActionEvent arg0) {
		this.executer();
	}
}
