package src.sauvegarde;

import src.Musique;
import src.PartieCourante;
import src.menus.MenuRepriseSauvegarde;

import java.io.*;
import java.util.*;

@SuppressWarnings("unchecked")
public class Sauvegarder {
    
    public static void creerSauvegarde(PartieCourante partieCourante) {
        try {
        	String pwd = System.getProperty("user.dir");
        	File dossier = new File(pwd + "/sauvegarde/");
        	if (!dossier.exists() || !dossier.isDirectory()) {
        		dossier.mkdir();
        	}
        	// Création de la liste des villes ou reprise de l'existante
        	File fichierVilles = new File(pwd + "/sauvegarde/Villes_Sauvegardees.save");
        	List<String> listeVilles;
        	if (fichierVilles.exists()) {
                FileInputStream fis = new FileInputStream(pwd + "/sauvegarde/Villes_Sauvegardees.save");
                ObjectInputStream ois = new ObjectInputStream(fis);
                listeVilles = (List<String>) ois.readObject();
                ois.close();
        	} else {
        		listeVilles = new ArrayList<String>();
        	}
        	String nomPartie = partieCourante.getNom();
            if (!listeVilles.contains(nomPartie)) {
                listeVilles.add(nomPartie);
                FileOutputStream fosv = new FileOutputStream(pwd + "/sauvegarde/Villes_Sauvegardees.save");
                ObjectOutputStream osv = new ObjectOutputStream(fosv);
                osv.writeObject(listeVilles);
                osv.close();
            }
            MenuRepriseSauvegarde.setListeVille(listeVilles);
        	
        	// Sauvegarde de la partie
            FileOutputStream fosp = new FileOutputStream(pwd + "/sauvegarde/" + nomPartie + ".city");
            ObjectOutputStream osp = new ObjectOutputStream(fosp);
            osp.writeObject(partieCourante);
            osp.close();
        } catch (FileNotFoundException e) {
        	e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static PartieCourante reprendreSauvegarde(String nomPartie) throws FileNotFoundException {
        try {
        	String pwd = System.getProperty("user.dir");
        	File dossier = new File(pwd + "/sauvegarde/");
        	if (!dossier.exists() || !dossier.isDirectory()) {
        		throw new FileNotFoundException();
        	}
            FileInputStream fis = new FileInputStream(pwd + "/sauvegarde/" + nomPartie + ".city");
            ObjectInputStream ois = new ObjectInputStream(fis);
            PartieCourante partieCourante = (PartieCourante) ois.readObject();
            ois.close();
            partieCourante.setTimer();
            Musique.setMusique();
            partieCourante.getCarte().updateDimensions();
            return partieCourante;
        } catch (FileNotFoundException e) {
        	throw new FileNotFoundException();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (Exception e) {
        	e.printStackTrace();
        }
		return null;
    }

    public static void renommerVilleSauvegarde(String ancienNom, String nouveauNom) throws FileNotFoundException {
        try {
            String pwd = System.getProperty("user.dir");
            FileInputStream fisp = new FileInputStream(pwd + "/sauvegarde/" + ancienNom + ".city");
            ObjectInputStream oisp = new ObjectInputStream(fisp);
            PartieCourante partieCourante = (PartieCourante) oisp.readObject();
            oisp.close();
            partieCourante.setNom(nouveauNom);

            FileOutputStream fosp = new FileOutputStream(pwd + "/sauvegarde/" + nouveauNom + ".city");
            ObjectOutputStream osp = new ObjectOutputStream(fosp);
            osp.writeObject(partieCourante);
            osp.close();
            File ville = new File(pwd + "/sauvegarde/" + ancienNom + ".city");
            ville.delete();
            
            List<String> listeVilles;
            FileInputStream fis;
            fis = new FileInputStream(pwd + "/sauvegarde/Villes_Sauvegardees.save");
            ObjectInputStream ois = new ObjectInputStream(fis);
            listeVilles = (List<String>) ois.readObject();
            ois.close();
            if (listeVilles.contains(ancienNom)) {
                listeVilles.remove(ancienNom);
                listeVilles.add(nouveauNom);
                FileOutputStream fosv = new FileOutputStream(pwd + "/sauvegarde/Villes_Sauvegardees.save");
                ObjectOutputStream osv = new ObjectOutputStream(fosv);
                osv.writeObject(listeVilles);
                osv.close();
            }
            MenuRepriseSauvegarde.setListeVille(listeVilles);
        } catch (FileNotFoundException e) {
            System.out.println("Echec! Le fichier "+ancienNom+" n'a pas pu être renommé.");
            throw new FileNotFoundException();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static void detruireVilleSauvegarde(String nomPartie) {
        try {
            String pwd = System.getProperty("user.dir");
            // Supprimer le .city
            File ville = new File(pwd + "/sauvegarde/" + nomPartie + ".city");
            ville.delete();
            // Mettre à jour la liste des noms
            List<String> listeVilles;
            FileInputStream fis;
            fis = new FileInputStream(pwd + "/sauvegarde/Villes_Sauvegardees.save");
            ObjectInputStream ois = new ObjectInputStream(fis);
            listeVilles = (List<String>) ois.readObject();
            ois.close();
            if (listeVilles.contains(nomPartie)) {
                listeVilles.remove(nomPartie);
                FileOutputStream fosv = new FileOutputStream(pwd + "/sauvegarde/Villes_Sauvegardees.save");
                ObjectOutputStream osv = new ObjectOutputStream(fosv);
                osv.writeObject(listeVilles);
                osv.close();
            }
            MenuRepriseSauvegarde.setListeVille(listeVilles);
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
