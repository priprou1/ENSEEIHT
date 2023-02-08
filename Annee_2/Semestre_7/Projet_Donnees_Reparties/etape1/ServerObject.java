import java.rmi.RemoteException;
import java.util.*;

public class ServerObject implements ServerObject_itf {

    private enum Lock {READ, WRITE};
	private Lock lock;
    private int id;
    private List<Client_itf> clientsLecteurs;
    private Client_itf clientEcrivain;
    private Object obj;

    public ServerObject(int id, Object obj) {
        this.id = id;
        this.clientsLecteurs = new ArrayList<Client_itf>();
        this.obj = obj;
        this.lock = null;
        System.out.println("Init d'un Server Object");
    }

    public void lock_read(Client_itf c) {
        System.out.println("Lock Read Server Obj");
        if (this.lock == Lock.WRITE) {
            try {
                System.out.println("Reduce lock Server Obj");
                Object nobj = clientEcrivain.reduce_lock(this.id);
                this.clientsLecteurs.add(clientEcrivain);
                clientEcrivain = null;
                this.obj = nobj; // Mise à jour de l'objet
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        }
        this.lock = Lock.READ;
        this.clientsLecteurs.add(c);
        System.out.println("En lecture uniquement : LR : ");
    }

    public void lock_write(Client_itf c) {
        System.out.println("Lock Write Server Obj");
        if (this.lock == Lock.WRITE) {
            try {
                System.out.println("invalidate writer Server Obj");
                if(!clientEcrivain.equals(c)) {
                    Object nobj = clientEcrivain.invalidate_writer(this.id);
                    this.obj = nobj; // Mise à jour de l'objet
                }
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        } else if (this.lock == Lock.READ) {
            for (Client_itf client : clientsLecteurs ) {
                try {
                    if(!client.equals(c)) {
                        client.invalidate_reader(this.id);
                        System.out.println("invalidate reader Server Obj");
                    }
                } catch (RemoteException e) {
                    e.printStackTrace();
                }
            }
        }
        this.lock = Lock.WRITE;
        this.clientsLecteurs.clear();// On enlève tous les clients lecteurs
        this.clientEcrivain = c;
        System.out.println("En ecriture uniquement : WR : ");
    }

    public Object get_Obj() {
        return this.obj;
    }
    
    
}
