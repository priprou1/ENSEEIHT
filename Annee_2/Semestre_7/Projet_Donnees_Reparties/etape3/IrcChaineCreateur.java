public class IrcChaineCreateur {
	Sentence_itf sentence;
    Sentence_itf sentence_chaine;
	static String		myName;

	public static void main(String argv[]) {
		
		if (argv.length != 1) {
			System.out.println("java IrcChaineCreateur <name>");
			return;
		}
		myName = argv[0];
	
		// initialize the system
		Client.init();
		
		// look up the IRC object in the name server
		// if not found, create it, and register it in the name server
		Sentence_itf s1 = (Sentence_itf)Client.lookup("IRC1");
		if (s1 == null) {
			s1 = (Sentence_itf)Client.create(new Sentence());
			Client.register("IRC1", s1);
		}
        Sentence_itf s2 = (Sentence_itf)Client.lookup("IRC2");
		if (s2 == null) {
			s2 = (Sentence_itf)Client.create(new Sentence_chaine("",s1));
			Client.register("IRC2", s2);
		}

		new IrcChaineCreateur(s1,s2);

	}

	public IrcChaineCreateur(Sentence_itf s1, Sentence_itf s2) {
        this.sentence = s1;
        this.sentence_chaine = s2;
	}
}
