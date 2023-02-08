import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.util.Map;
import java.util.concurrent.Semaphore;
import java.util.HashMap;

public class Server extends UnicastRemoteObject implements Server_itf {
    private Map<Integer, ServerObject> serverobjects;
    private Map<String, Integer> registre;
    private Map<Integer, Semaphore> locks;
    private Semaphore creation;

    public Server() throws RemoteException {
        // Créer le dico des ServerObjects
        this.serverobjects = new HashMap<Integer, ServerObject>();
        this.registre = new HashMap<String, Integer>();
        this.locks = new HashMap<Integer, Semaphore>();
        this.creation = new Semaphore(1);
    }

    /* Retourne l'ID de l'objet qui a le nom donné en paramètre */
    /*id = -1 si l'obj de nom name n'existe pas, >=0 sinon */
    public int lookup(String name) throws RemoteException {
        int id = -1;
        try {
            creation.acquire();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        if (registre.containsKey(name)) {
            id = registre.get(name);
            creation.release();
        }
        return id;
    }

    /* Enregistrer un nom associé à l'id de l'objet dans le serveur de nom*/
    public void register(String name, int id) throws RemoteException {
            // Si l'ID n'est pas dans serverobject on throw RemoteException
            if (id >= serverobjects.size()) {
                throw(new RemoteException());
            }
            registre.put(name, id);
            creation.release();
    }

    /* Créer un objet dans les servers object et retourner son ID  */
    public int create(Object o) throws RemoteException {
        int id = serverobjects.size();
        // Ajouter l'objet
        ServerObject sobj = new ServerObject(id, o);
        serverobjects.put(id, sobj);
        System.out.println(id);
        // Ajouter le sémaphore associé pour éviter les problèmes de Synchro
        Semaphore newLock = new Semaphore(1);
        locks.put(id, newLock);
        return id;
    }

    public Object lock_read(int id, Client_itf client) throws RemoteException {
        try {
            locks.get(id).acquire();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        ServerObject sobj = serverobjects.get(id);
        sobj.lock_read(client);
        System.out.println(((Sentence) sobj.get_Obj()).read());
        locks.get(id).release();
        return sobj.get_Obj();
    }

    public Object lock_write(int id, Client_itf client) throws RemoteException {
        try {
            locks.get(id).acquire();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        ServerObject sobj = serverobjects.get(id);
        sobj.lock_write(client);
        System.out.println(((Sentence) sobj.get_Obj()).read());
        locks.get(id).release();
        return sobj.get_Obj();
    }

    public static void main(String args[]) {
  
        try {
            Server_itf server = new Server();
            LocateRegistry.createRegistry(2021);
            try {
                Naming.rebind("//localhost:2021/serveur", server);
                System.out.println("bind réussi");
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }

        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }
}
