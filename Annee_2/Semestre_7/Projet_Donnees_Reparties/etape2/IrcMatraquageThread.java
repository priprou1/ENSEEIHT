import java.util.*;
public class IrcMatraquageThread implements Runnable {
    static String name;
	static ArrayList<Thread> threads = new ArrayList<>();
	Random rand = new Random();
    Sentence_itf sentence;
    private String nameT;


    public static void main(String argv[]) {
		if (argv.length != 2) {
			System.out.println("java IrcMatraquage <Name> <nbThread>");
			return;
		}

        name = argv[0];

        int nb = Integer.parseInt(argv[1]);
		System.out.println(nb);
        for (int i = 0; i<nb; i++) {
			// On créé autant de Thread que ce que l'utilisateur demande.
            Thread t = new Thread(new IrcMatraquageThread(i, name+i));
            t.start();
            threads.add(t);
        }
    }

    @Override
	public void run() {
		// initialisation du client
		Client.init();
		
		// Recherche de l'objet IRC dans le serveur de nom
		// s'il n'est pas trouvé, alors on le créer et on le nomme.
		Sentence_itf s = (Sentence_itf) Client.lookup(name);
		if (s == null) {
			s = (Sentence_itf) Client.create(new Sentence());
			Client.register(name, s);
		}
		this.sentence = s;

		// On fait à l'infini des demandes d'écriture et de lecture à des intervalles de temps random pour
		// augmenter la probabilité d'avoir plusieurs demandes en même temps sur le serveur.
        while(true) {
            this.lire();
            try {
                Thread.sleep((int)(Math.random() * 1000));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            this.ecrire();
            try {
                Thread.sleep((int)(Math.random() * 1000));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

	}

    public IrcMatraquageThread(int num, String nom) {
        this.nameT = nom;
    }

    public void lire () {
		
		// lock the object in read mode
		this.sentence.lock_read();
		
		// invoke the method
		String s = ((Sentence_itf)(this.sentence)).read();
		int nombreAleatoire = rand.nextInt(100 - 10 + 1) + 10;
		try {
			Thread.sleep(nombreAleatoire);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// unlock the object
		this.sentence.unlock();
		
		// display the read value
		System.out.println(this.nameT + " a lu : " + s);
	}

    public void ecrire () {
		
		// get the value to be written from the buffer
        String s = this.nameT + " est le dernier ecrivain.";
        	
        // lock the object in write mode
		this.sentence.lock_write();
		
		// invoke the method
		((Sentence_itf)(this.sentence)).write(this.nameT+" wrote "+s);
		
		// unlock the object
		this.sentence.unlock();
	}
}
