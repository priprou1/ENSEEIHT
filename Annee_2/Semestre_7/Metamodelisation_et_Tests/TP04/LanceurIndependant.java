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
		// Récupérer la classe
		Class<?> classeTest = Class.forName(nomClasse);

		Method[] methods = classeTest.getMethods();

		// Récupérer les méthodes "preparer" et "nettoyer"
		Method preparer = null;  // initialiser à une méthode qui ne fait rien
		Method nettoyer = null;
		for (Method m : methods) {
			if (m.isAnnotationPresent(Avant.class)){
				preparer = m;
			} else if (m.isAnnotationPresent(Apres.class)){
				nettoyer = m;
			}
		}




		// Instancier l'objet qui sera le récepteur des tests
		Constructor<?> constructor;
		try {
			constructor = classeTest.getConstructor();
			Object objet = constructor.newInstance();
			
			// Exécuter les méthods de test
			for (Method m : methods) {
				if (m.isAnnotationPresent(UnTest.class) && m.getAnnotation(UnTest.class).enabled()){
					if (preparer != null) {
						preparer.invoke(objet);
					}
					this.nbTestsLances++;
					try {
						m.invoke(objet);
						if (m.getAnnotation(UnTest.class).expected().getName() != "UnTest$NoExceptionExpected") {
							this.nbEchecs++;
						}

					}catch (InvocationTargetException e) {
						if (m.getAnnotation(UnTest.class).expected().isInstance(e.getCause())) {
						}else if (e.getCause() instanceof Echec) {
							//System.out.println("Test non passé");
							this.nbEchecs++;
						} else {
							this.nbErreurs++;
						}
					}
				}
			}
			if (nettoyer != null) {
				nettoyer.invoke(objet);
			}

		} catch (NoSuchMethodException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SecurityException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	public static void main(String... args) {
		LanceurIndependant lanceur = new LanceurIndependant(args);
	}

}
