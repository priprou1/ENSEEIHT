import java.util.Random;

public class IrcMatraquage {
    SharedObject		sentence;
	static String		myName;
    static IrcMatraquage irc;
	Random rand = new Random();

    public static void main(String argv[]) {
		
		if (argv.length != 2) {
			System.out.println("java Irc <name> <time>");
			return;
		}
		myName = argv[0];
	
		// initialisation du client
		Client.init();
		
		// Recherche de l'objet IRC dans le serveur de nom
		// s'il n'est pas trouvé, alors on le créer et on le nomme.
		SharedObject s = Client.lookup("Irc");
		if (s == null) {
			s = Client.create(new Sentence());
			Client.register("Irc", s);
		}


		irc = new IrcMatraquage(s);
		int temps;
		// On fait à l'infini des demandes d'écriture et de lecture à des intervalles de temps random pour
		// augmenter la probabilité d'avoir plusieurs demandes en même temps sur le serveur.
        while(true) {
			temps = (int) (Math.random() * Integer.parseInt(argv[1])) + 50;
            irc.lire();
            try {
                Thread.sleep(temps);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            irc.ecrire();
            try {
                Thread.sleep(temps);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

	}

    public IrcMatraquage(SharedObject s) {
        sentence = s;
    }

    public void lire () {
		
		// lock the object in read mode
		irc.sentence.lock_read();
		
		// invoke the method
		String s = ((Sentence)(irc.sentence.obj)).read();
		int nombreAleatoire = rand.nextInt(100 - 10 + 1) + 10;
		try {
			Thread.sleep(nombreAleatoire);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// unlock the object
		irc.sentence.unlock();
		
		// display the read value
		System.out.println(myName + " a lu : " + s);
	}

    public void ecrire () {
		
		// get the value to be written from the buffer
        String s = myName + " est le dernier ecrivain.";
        	
        // lock the object in write mode
		irc.sentence.lock_write();
		
		// invoke the method
		((Sentence)(irc.sentence.obj)).write(myName+" wrote "+s);
		
		// unlock the object
		irc.sentence.unlock();
	}
}
