import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.net.*;
import java.util.*;

public class Client extends UnicastRemoteObject implements Client_itf {

	private static Server_itf serveur;
	private static Client_itf client;
	private static Map<Integer, SharedObject> sharedobjects;
	private static boolean iscreated = false;
	

	public Client() throws RemoteException {
		super();
	}


///////////////////////////////////////////////////
//         Interface to be used by applications
///////////////////////////////////////////////////

	// initialization of the client layer
	public static void init() {
		// récupèrer le server et le mettre en attribut pour pouvoir appeler ces méthodes
		try {
			serveur = (Server_itf) Naming.lookup("//localhost:2021/serveur");
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NotBoundException e) {
			e.printStackTrace();
		}
		// Créer un client pour pouvoir ensuite le mettre en argument lors des appels des méthodes du server
		if (!iscreated) {
			try {
				client = new Client();
			} catch (RemoteException e) {
				System.out.println("Pb Création client");
			}
			iscreated = true;
			sharedobjects = new HashMap<Integer, SharedObject>();
		}
	}
	
	// lookup in the name server
	public static SharedObject lookup(String name) {
		SharedObject sobj = null;
		try {
			int id = serveur.lookup(name);
			if (id >= 0) {
				sobj = new SharedObject(null, id);
				sharedobjects.put(id, sobj);
			}
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return sobj;
	}		
	
	// binding in the name server
	public static void register(String name, SharedObject_itf so) {
		SharedObject sobj = (SharedObject) so;
		int id = sobj.get_id();
		try {
			serveur.register(name, id);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
	}

	// creation of a shared object
	public static SharedObject create(Object o) {
		SharedObject sobj = null;
		try {
			int id = serveur.create(o);
			sobj = new SharedObject(o, id);
			sharedobjects.put(id, sobj);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return sobj;
	}
	
/////////////////////////////////////////////////////////////
//    Interface to be used by the consistency protocol
////////////////////////////////////////////////////////////

	// request a read lock from the server
	public static Object lock_read(int id) {
		Object obj = null;
		try {
			obj = serveur.lock_read(id, Client.client);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return obj;
	}

	// request a write lock from the server
	public static Object lock_write (int id) {
		Object obj = null;
		try {
			obj = serveur.lock_write(id, Client.client);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return obj;
	}

	// receive a lock reduction request from the server
	public Object reduce_lock(int id) throws java.rmi.RemoteException {
		Object obj = Client.sharedobjects.get(id).reduce_lock();
		return obj;
	}


	// receive a reader invalidation request from the server
	public void invalidate_reader(int id) throws java.rmi.RemoteException {
		SharedObject sobj = sharedobjects.get(id);
		sobj.invalidate_reader();
	}


	// receive a writer invalidation request from the server
	public Object invalidate_writer(int id) throws java.rmi.RemoteException {
		Object obj = sharedobjects.get(id).invalidate_writer();
		return obj;
	}
}
