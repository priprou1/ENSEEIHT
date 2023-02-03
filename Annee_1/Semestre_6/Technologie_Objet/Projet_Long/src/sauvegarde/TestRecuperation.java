package src.sauvegarde;

import src.PartieCourante;

import java.io.FileNotFoundException;

public class TestRecuperation {
    public static void main(String[] args) {
    	
    	PartieCourante partie1 = new PartieCourante();

        PartieCourante partie2;
		try {
			partie2 = Sauvegarder.reprendreSauvegarde("test");
			assert(partie1.getFinances() == partie2.getFinances());
			System.out.print("récupération faite");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

    }
}
