import java.lang.reflect.*;
import java.util.*;

/** L'objectif est de faire un lanceur simple sans utiliser toutes les clases
  * de notre architecture JUnit.   Il permet juste de valider la compréhension
  * de l'introspection en Java.
  */
public class LanceurIndependant {
	private int nbTestsLances;
	private int nbErreurs;
	private int nbEchecs;
	private List<Throwable> erreurs = new ArrayList<>();

	public LanceurIndependant(String... nomsClasses) {
	    System.out.println();

		// Lancer les tests pour chaque classe
		for (String nom : nomsClasses) {
			try {
				System.out.print(nom + " : ");
				this.testerUneClasse(nom);
				System.out.println();
			} catch (ClassNotFoundException e) {
				System.out.println(" Classe inconnue !");
			} catch (Exception e) {
				System.out.println(" Problème : " + e);
				e.printStackTrace();
			}
		}

		// Afficher les erreurs
		for (Throwable e : erreurs) {
			System.out.println();
			e.printStackTrace();
		}

		// Afficher un bilan
		System.out.println();
		System.out.printf("%d tests lancés dont %d échecs et %d erreurs.\n",
				nbTestsLances, nbEchecs, nbErreurs);
	}


	public int getNbTests() {
		return this.nbTestsLances;
	}


	public int getNbErreurs() {
		return this.nbErreurs;
	}


	public int getNbEchecs() {
		return this.nbEchecs;
	}


	private void testerUneClasse(String nomClasse)
		throws ClassNotFoundException, InstantiationException,
						  IllegalAccessException
	{
		try {
		// Récupérer la 
		Class<?> classeTest = Class.forName(nomClasse);

		// Récupérer les méthodes "preparer" et "nettoyer"
		


		

		
		// Instancier l'objet qui sera le récepteur des tests
		Constructor<?> constructor = classeTest.getConstructor();
		Object objet = constructor.newInstance();
		

		// Exécuter les méthods de test
		Method[] tests = classeTest.getMethods();


		// preparer


		// tests
		for (Method m : tests) {
			if (m.getName().startsWith("test") && Modifier.isPublic(m.getModifiers()) && m.getParameterCount()==0) {
				try{
					Method preparer = classeTest.getMethod("preparer");
					preparer.invoke(objet);
				} catch (NoSuchMethodException e) {
					System.out.println(" Pas de méthode preparer");
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}  
				try{
					// Executer la méthode
					this.nbTestsLances++;
					m.invoke(objet);
					//System.out.println("test passé");
				} catch (InvocationTargetException e) {
					if (e.getCause() instanceof Echec) {
						//System.out.println("Test non passé");
						this.nbEchecs++;
					} else {
						this.nbErreurs++;
					}
				}
			}
		}

		// nettoyer
		try {
			Method nettoyer = classeTest.getMethod("nettoyer");
			nettoyer.invoke(objet);
		} catch (NoSuchMethodException e) {
			System.out.println(" Pas de méthode nettoyer");
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}  
	
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
	}

	public static void main(String... args) {
		LanceurIndependant lanceur = new LanceurIndependant(args);
	}

}
