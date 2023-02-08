import java.util.Random;

public class IrcMatraquagePlusieursObjets {
	SharedObject[] sentence = {null, null, null};
	static String		myName;
    static IrcMatraquagePlusieursObjets irc;
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
		// On fait cela pour 3 objets différents.
		SharedObject s1 = Client.lookup("Irc1");
		if (s1 == null) {
			s1 = Client.create(new Sentence());
			Client.register("Irc1", s1);
		}
		SharedObject s2 = Client.lookup("Irc2");
		if (s2 == null) {
			s2 = Client.create(new Sentence());
			Client.register("Irc2", s2);
		}
		SharedObject s3 = Client.lookup("Irc3");
		if (s3 == null) {
			s3 = Client.create(new Sentence());
			Client.register("Irc3", s3);
		}

		irc = new IrcMatraquagePlusieursObjets(s1, s2, s3);
		int temps;
        while(true) {
			temps = (int) (Math.random() * Integer.parseInt(argv[1])) + 50;

			Random rand = new Random();
			int nombreAleatoire = (int) rand.nextInt(3);
			// On écrit et lit aléatoirement sur un des 3 objets que l'on a créé.
            irc.lire(nombreAleatoire);
            try {
                Thread.sleep(temps);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            irc.ecrire(nombreAleatoire);
            try {
                Thread.sleep(temps);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

	}

    public IrcMatraquagePlusieursObjets(SharedObject s1,SharedObject s2,SharedObject s3) {
        sentence[0] = s1;
		sentence[1] = s2;
		sentence[2] = s3;
    }

    public void lire (int nb) {
		
		// lock the object in read mode
		irc.sentence[nb].lock_read();
		
		// invoke the method
		String s = ((Sentence)(irc.sentence[nb].obj)).read();
		int nombreAleatoire = rand.nextInt(100 - 10 + 1) + 10;
		try {
			Thread.sleep(nombreAleatoire);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// unlock the object
		irc.sentence[nb].unlock();
		
		// display the read value
		System.out.println(myName + " a lu sur le SO n°" + nb + " : " + s);
	}

    public void ecrire (int nb) {
		
		// get the value to be written from the buffer
        String s = myName + " est le dernier ecrivain.";
        	
        // lock the object in write mode
		irc.sentence[nb].lock_write();
		
		// invoke the method
		((Sentence)(irc.sentence[nb].obj)).write(myName+" wrote "+s);
		
		// unlock the object
		irc.sentence[nb].unlock();
	}
}
