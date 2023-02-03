import java.util.List;
import java.util.Observable;
import java.util.Observer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

public class Chat extends Observable implements Iterable<Message> {

	private List<Message> messages;
	private List<Observer> listObserver;

	public Chat() {
		this.messages = new ArrayList<Message>();
		this.listObserver = new ArrayList<Observer>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
		notifierObservateurs(m);
	}

	@Override
	public Iterator<Message> iterator() {
		return this.messages.iterator();
	}
	
	public void ajouterObservateur(Observer o) {
		this.listObserver.add(o);
	}

	public void supprimerObservateur(Observer o) {
		this.listObserver.remove(o);
	}

	public void notifierObservateurs(Message m) {
		for(int i = 0; i<this.listObserver.size(); i++) {
			Observer o = this.listObserver.get(i);
			o.update(this, m);
		}
	}

}
