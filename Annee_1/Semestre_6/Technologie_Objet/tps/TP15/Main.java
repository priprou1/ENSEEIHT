import java.awt.EventQueue;

public class Main {

	private JFrame fenetre;
	
	private VueChat vue;
	
	private JTextArea
	
	Main(VueChat vue) {
		this.vue = vue;
	}
	
	
	
	
	public static void main (String[] args) {
		VueChat vue = new VueChat();
		Chat chat = new Chat();
		Message m = new MessageTexte("Moi", "Coucou");
		
		chat.ajouterObservateur(vue);
		
		chat.ajouter(m);
		

		
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new Main(vue);
			}
		});
	}
}
