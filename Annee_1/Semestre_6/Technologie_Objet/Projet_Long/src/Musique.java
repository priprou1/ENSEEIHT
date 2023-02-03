package src;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.FloatControl;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

public class Musique{
	
	private static transient Timer musique;
	
	private static boolean musiqueJoue = false;
	
	private static int numeroListe;
	
	private static List<String> playListJeu = Musique.construireListeJeu();
	
	private static List<String> playListMenu = Musique.construireListeMenus();

    private static transient FloatControl volume = null;
    
    private static float hauteur = 0f;
    
    private static boolean arretMusique = false;
    
    private static boolean musiquePartie = false;
    
    private static boolean musiqueFin = false;
	

	public static void setMusique(boolean musiqueJoue) {
		Musique.musiqueJoue = musiqueJoue;
	}
	
	public static void setMusiquePartie(boolean musiquePartie) {
		if (Musique.musiquePartie != musiquePartie) {
			numeroListe = -1;
			Musique.musiquePartie = musiquePartie;
			setMusique();
		}
	}
	
	public static void setMusique() {
		Musique.stopMusique();
		Musique.setMusique(true);
		Musique.arretMusique = false;
		numeroListe = -1;
		Musique.musique = new Timer();
		Musique.musique.schedule(new TimerTask(){
		
			@Override
			public void run() {

				if (musiqueJoue) avancéeListe(musiquePartie ? playListJeu : playListMenu);

			}
		
		}, 0, 1);
	}
	
	public static void stopMusique() {
		Musique.arretMusique = true;
		while(!Musique.musiqueFin & Musique.arretMusique & Musique.musiqueJoue) {
			System.out.print("");//je ne comprends pas pourquoi ça marche pas sans cette ligne
		}
		if (Musique.musique != null) Musique.musique.cancel();
		Musique.musiqueFin = false;
	}
	
    
    private static void musiqueJeu(String nomMusique) {
    	try {
			AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(new File(nomMusique));
			Clip clip = AudioSystem.getClip();
			clip.open(audioInputStream);
			Musique.volume = (FloatControl) clip.getControl(FloatControl.Type.MASTER_GAIN);
			Musique.volume.setValue(Musique.hauteur);
			clip.start();
			long tempsPasse = 0;
			long dernierTempsPris = System.currentTimeMillis();
			while (clip.getMicrosecondLength()/1000 > tempsPasse) {
				if (arretMusique) {
					clip.stop();
					clip.close();
					Musique.arretMusique = false;
					Musique.musiqueFin = true;
					Musique.setMusique(false);
					return;
				} else if (!musiqueJoue & clip.isRunning()) {
					clip.stop();
				} else if (musiqueJoue & !clip.isRunning()) {
					clip.start();
					dernierTempsPris = System.currentTimeMillis();
				} else if (musiqueJoue){
					long nouveauTempsPris = System.currentTimeMillis();
					tempsPasse += nouveauTempsPris - dernierTempsPris;
					dernierTempsPris = nouveauTempsPris;
				}
			}
    	} catch (UnsupportedAudioFileException  | IOException | LineUnavailableException e) {
			e.printStackTrace();
		}
    	
    }
    
   
    
    public static void setVolume(float level) {//Entre 0 et 1
    	Musique.hauteur = (float) Math.max(10 * Math.log10(level * Math.pow(10, 0.6)), -80);
    	if (Musique.volume != null) Musique.volume.setValue(Musique.hauteur);
    }
    
    private static List<String> construireListeJeu() {
    	List<String> playlist = new ArrayList<String>();
    	playlist.add("src/musique/musique3.wav");
    	return playlist;
    }
    
    private static List<String> construireListeMenus() {
    	List<String> playlist = new ArrayList<String>();
    	playlist.add("src/musique/musique1.wav");
    	playlist.add("src/musique/musique2.wav");
    	return playlist;
    }
    
    private static void avancéeListe(List<String> playList) {
    	numeroListe++;
		numeroListe = numeroListe%playList.size();
		musiqueJeu(playList.get(numeroListe));
    }
}
