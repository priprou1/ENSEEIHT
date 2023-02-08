
import java.io.*;

public class SharedObject implements Serializable, SharedObject_itf {

	public enum Locks {NL,RLC, WLC, RLT, WLT, RLT_WLC};
	private Locks lock;
	public Object obj; //référence à l'objet quand il est cohérent
	private int id;


	public SharedObject (Object obj, int id){
		this.lock = Locks.NL;
		this.obj = obj;
		this.id = id;
	}

	public int get_id() {
		return this.id;
	}


	// invoked by the user program on the client node
	public void lock_read() {
		System.out.println("LR : DEBUT : " + this.lock);
		if (this.lock == Locks.NL) {
			this.obj = Client.lock_read(this.id);
			this.lock = Locks.RLT;
		} else
		if (this.lock == Locks.WLC) {
			this.lock = Locks.RLT_WLC;
		} else {
			this.lock = Locks.RLT;
		}
		System.out.println("LR : FIN : " + this.lock);
	}

	// invoked by the user program on the client node
	public void lock_write() {
		System.out.println("LW : DEBUT : " + this.lock);
		if (this.lock == Locks.NL || this.lock == Locks.RLC) {
			this.obj = Client.lock_write(this.id);
		}
		this.lock = Locks.WLT;
		System.out.println("LW : FIN : " + this.lock);
	}

	// invoked by the user program on the client node
	public synchronized void unlock() {
		System.out.println("UL : DEBUT : " + this.lock);
		if (this.lock == Locks.WLT || this.lock == Locks.RLT_WLC) {
			this.lock = Locks.WLC;
		} else {
			this.lock = Locks.RLC;
		}
		notify();
		System.out.println("UL : FIN : " + this.lock);
	}


	// callback invoked remotely by the server
	public synchronized Object reduce_lock() {
		System.out.println("RL : DEBUT : " + this.lock);
		if (this.lock == Locks.WLT) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		if (this.lock == Locks.RLT_WLC) {
			this.lock = Locks.RLT;
		} else {
			this.lock = Locks.RLC;
		}
		System.out.println("RL : FIN : " + this.lock);
		return this.obj;
	}

	// callback invoked remotely by the server
	public synchronized void invalidate_reader() {
		System.out.println("IR : DBUT : " + this.lock);
		if (this.lock == Locks.RLT) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		this.lock = Locks.NL;
		System.out.println("IR : FIN : " + this.lock);
	}

	public synchronized Object invalidate_writer() {
		System.out.println("IW : DEBUT : " + this.lock);
		if (this.lock == Locks.WLT | this.lock == Locks.RLT_WLC) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		this.lock = Locks.NL;
		
		System.out.println("IW : FIN : " + this.lock);
		return this.obj;
	}

	public Locks getLock() {
		return this.lock;
	}
}
