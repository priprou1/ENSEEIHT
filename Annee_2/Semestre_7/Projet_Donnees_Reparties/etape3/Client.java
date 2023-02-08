import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.lang.reflect.InvocationTargetException;
import java.net.*;
import java.util.*;
import java.io.*;

public class Client extends UnicastRemoteObject implements Client_itf {
	
	private static Server_itf serveur;
	private static Client_itf client;
	private static Map<Integer, SharedObject> sharedobjects;
	private static boolean iscreated = false;
	private static boolean hasserver = false;

	public Client() throws RemoteException {
		super();
	}


///////////////////////////////////////////////////
//         Interface to be used by applications
///////////////////////////////////////////////////

	// initialization of the client layer
	public static void init() {
		// récupèrer le server et le mettre en attribut pour pouvoir appeler ses méthodes
		try {
			serveur = (Server_itf) Naming.lookup("//localhost:2021/serveur");
			Client.hasserver = true;
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
	public static Object lookup(String name) {
		Object stub = null;
		try {
			IntClassTransport idclass = serveur.lookup(name);
			int id = idclass.getId();
			Class<?> classeobj = idclass.getClasse();
			if (id >= 0) {
				stub = Client.createStub(classeobj, id);
				sharedobjects.put(id, (SharedObject) stub);
			}			
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		}
		return stub;
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
	public static Object create(Object o) {
		Class<?> classeobj = o.getClass();
		Object stub = null;
		try {
			int id = serveur.create(o);
			stub = Client.createStub(classeobj, id);
			sharedobjects.put(id, (SharedObject) stub);
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return stub;
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
		sharedobjects.get(id).invalidate_reader();
	}

	// receive a writer invalidation request from the server
	public Object invalidate_writer(int id) throws java.rmi.RemoteException {
		Object obj = sharedobjects.get(id).invalidate_writer();
		return obj;
	}

/////////////////////////////////////////////////////////////
//    Other Methods
////////////////////////////////////////////////////////////

	/**
	 * Méthode pour créer un stub à partir de la classe de l'objet qui sera en attribut du stub et de son identifiant
	 * @param classeobj Classe de l'objet pour lequel on veut créer un stub
	 * @param id Identifiant de l'objet
	 * @return Le stub créé
	 */
	public static Object createStub(Class<?> classeobj, int id) {
		Object stub = null;
		String nomclasseobj = classeobj.getName();
		String nomclassestub = nomclasseobj + "_stub";
		Class<?> classestub = null;

		try {
			// Récupérer la classe du stub
			classestub = Class.forName(nomclassestub);
		} catch (ClassNotFoundException e) {
			// La classe n'existe pas encore donc on créer le fichier de définition de cette classe
			CreateurClassStub.createclass(nomclasseobj);
			try {
				// Compilation du fichier pour générer la classe
				String [] commande={"javac",nomclassestub + ".java"};
				Process proc = Runtime.getRuntime().exec(commande);
				proc.waitFor();
				// Rajout de la classe dans le classloader pour pourvoir l'utiliser
				ClassLoader classloader = ClassLoader.getSystemClassLoader();
				classestub = classloader.loadClass(nomclassestub);
			} catch (IOException e1) {	
				e1.printStackTrace();
			} catch (ClassNotFoundException e1) {	
				e1.printStackTrace();
			} catch (InterruptedException e1) {	
				e1.printStackTrace();
			}
		}
		try {
			// Création du stub
			stub = (Object) classestub.getDeclaredConstructor(Object.class, int.class).newInstance(null,id);
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		}
		return stub;
	}

	/**
	 * Méthode pour cher le sharedObject à partir de son identifiant
	 * @param id Identifiant de l'objet
	 * @return Le sharedObject associé à l'id ou null si non existant
	 */
	public static SharedObject lookupId(int id) {
		SharedObject sobj = null;
		if (Client.hasserver) {
			sobj = Client.sharedobjects.get(id);
		}
		return sobj;
	}

	/**
	 * Getter pour le booléen si le serveur a déjà été créé
	 * @return Booléen si le serveur à déjà été créé ou non
	 */
	public static boolean gethasserver() {
		return Client.hasserver;
	}

	/**
	 * Récupérer l'id d'un objet à partir de son nom
	 * @param name nom de l'objet
	 * @return id de l'objet
	 */
	public static int getID(String name) {
		IntClassTransport idclass;
		int id = -1;
		try {
			idclass = serveur.lookup(name);
			id = idclass.getId();
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return id;
	}

	/**
	 * Rajouter le sharedobject dans la liste des sharedobjects
	 * @param sobj sharedobject à ajouter
	 * @param id identifiant du sharedobject
	 */
	public static void addSharedObject(SharedObject sobj, int id) {
		sharedobjects.put(id, sobj);
	}
}
