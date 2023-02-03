package src.menus.boutons;

import java.awt.*;
import javax.swing.*;
import javax.swing.event.*;

import src.Musique;

@SuppressWarnings("serial")
public class Commande_Volume extends JSlider implements ChangeListener {

	private static float volume = 0.5f;
	
	public Commande_Volume() {
		super();
		
		this.setFont(new Font("Courier", Font.PLAIN, 12));
		
		this.setMaximum(100);
		this.setMinimum(0);
		this.setMajorTickSpacing(10);
		this.setMinorTickSpacing(2);
		
		this.setPaintTicks(true);
		this.setPaintTrack(true);
		this.setPaintLabels(true);
		
		this.setOpaque(false);
		
		this.addChangeListener(this);
		
		this.setValue((int) (Commande_Volume.volume*100));
		
	}

	@Override
	public void stateChanged(ChangeEvent arg0) {
		Commande_Volume.volume = ((float) this.getValue())/100;
		Musique.setVolume(Commande_Volume.volume);
	}
	
}
