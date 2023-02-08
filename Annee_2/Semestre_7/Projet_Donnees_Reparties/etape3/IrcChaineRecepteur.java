public class IrcChaineRecepteur {
    Sentence_itf sentence_chaine;
    static String		myName;
    static IrcChaineRecepteur irc;

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
        Sentence_itf s2 = (Sentence_itf)Client.lookup("IRC2");
        if (s2 == null) {
            s2 = (Sentence_itf)Client.create(new Sentence_chaine());
            Client.register("IRC2", s2);
        }

        IrcChaineRecepteur.irc = new IrcChaineRecepteur(s2);
        int ids1 = Client.getID("IRC1");
        if (ids1 >= 0) {
            SharedObject sobj = Client.lookupId(ids1);
            if (sobj != null) {
                System.out.println("Le SharedObject chainé est bien enregistré dans le client");
            } else {
                System.out.println("Le SharedObject chainé n'est pas enregistré dans le client");
            }
        } else {
            System.out.println("Le SharedObject chainé n'est pas sur le server");
        }
    }

    public IrcChaineRecepteur(Sentence_itf s) {
        this.sentence_chaine = s;
    }
}

