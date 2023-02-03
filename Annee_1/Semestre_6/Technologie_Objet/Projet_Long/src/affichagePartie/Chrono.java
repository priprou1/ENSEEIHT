package src.affichagePartie;

public class Chrono implements Runnable {
	private final int PAUSE = 100;
	
	public void run() {
		
		while (true) {
			try {
				Thread.sleep(PAUSE);
			} catch (InterruptedException e) {}
			
			AffichagePartie.affichageCarte.repaint();
		}
	}
}
