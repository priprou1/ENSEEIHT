import java.io.*;

public class SharedObject implements Serializable, SharedObject_itf {

	public enum Lock {NL,RLC, WLC, RLT, WLT, RLT_WLC};
	private Lock lock;
	public Object obj; //référence à l'objet quand il est cohérent
	private int id;

	public SharedObject (Object obj, int id){
		this.lock = Lock.NL;
		this.obj = obj;
		this.id = id;
	}

	public int get_id() {
		return this.id;
	}

	
	// invoked by the user program on the client node
	public void lock_read() {
		System.out.println("LR : DEBUT : " + this.lock);
		if (this.lock == Lock.NL) {
			this.obj = Client.lock_read(this.id);
			this.lock = Lock.RLT;
		} else
		if (this.lock == Lock.WLC) {
			this.lock = Lock.RLT_WLC;
		} else {
			this.lock = Lock.RLT;
		}
		System.out.println("LR : FIN : " + this.lock);
	}

	// invoked by the user program on the client node
	public void lock_write() {
		System.out.println("LW : DEBUT : " + this.lock);
		if (this.lock == Lock.NL || this.lock == Lock.RLC) {
			this.obj = Client.lock_write(this.id);
		}
		this.lock = Lock.WLT;
		System.out.println("LW : FIN : " + this.lock);
	}

	// invoked by the user program on the client node
	public synchronized void unlock() {
		System.out.println("UL : DEBUT : " + this.lock);
		if (this.lock == Lock.WLT || this.lock == Lock.RLT_WLC) {
			this.lock = Lock.WLC;
		} else {
			this.lock = Lock.RLC;
		}
		notify();
		System.out.println("UL : FIN : " + this.lock);
	}


	// callback invoked remotely by the server
	public synchronized Object reduce_lock() {
		// penser au cas où on est en WLT ou RLT_WLC
		System.out.println("RL : DEBUT : " + this.lock);
		if (this.lock == Lock.WLT) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		if (this.lock == Lock.RLT_WLC) {
			this.lock = Lock.RLT;
		} else {
			this.lock = Lock.RLC;
		}
		System.out.println("RL : FIN : " + this.lock);
		return this.obj;
	}

	// callback invoked remotely by the server
	public synchronized void invalidate_reader() {
		System.out.println("IR : DBUT : " + this.lock);
		if (this.lock == Lock.RLT) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		this.lock = Lock.NL;
		System.out.println("IR : FIN : " + this.lock);
	}

	public synchronized Object invalidate_writer() {
		if (this.lock == Lock.WLT | this.lock == Lock.RLT_WLC) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		this.lock = Lock.NL;
		System.out.println("IW : FIN : " + this.lock);
		return this.obj;
	}

	public Lock getLock() {
		return this.lock;
	}

	/**
	 * Méthode qui overwrite readresolve Serialisation
	 * @return l'objet désérialisé
	 */
	public Object readResolve() throws ObjectStreamException {
		// récupère l'objet du client s'il est déjà référencé
		SharedObject so = Client.lookupId(id);
		if (so == null && Client.gethasserver()) {
			// Si l'objet n'existe pas encore dans le client et que ce n'est pas un serveur
			Class<?> classobj = this.obj.getClass();
			// On crée un stub pour l'ajouter sur le client
			so = (SharedObject) Client.createStub(classobj, id);
			Client.addSharedObject(so, id);
		} else {
			// Sinon on renvoie l'objet directement 
			return this;
		}
		return so;
	}
}
