package simplepdl.manip;

import java.io.IOException;
import java.util.Collections;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import petrinet.*;
import simplepdl.*;
import simplepdl.Process;

public class SimplePDL2petrinet {
	
	static PetrinetFactory myFactory;
	static PetriNet petriNet;

	public static void main(String[] args) {
		
		// Charger le package SimplePDL afin de l'enregistrer dans le registre d'Eclipse.
		SimplepdlPackage packageInstance = SimplepdlPackage.eINSTANCE;
		
		// Charger le package PetriNet afin de l'enregistrer dans le registre d'Eclipse.
		PetrinetPackage packageInstancep = PetrinetPackage.eINSTANCE;
				
		// Enregistrer l'extension ".xmi" comme devant Ãªtre ouverte Ã 
		// l'aide d'un objet "XMIResourceFactoryImpl"
		Resource.Factory.Registry reg = Resource.Factory.Registry.INSTANCE;
		Map<String, Object> m = reg.getExtensionToFactoryMap();
		m.put("xmi", new XMIResourceFactoryImpl());

		// CrÃ©er un objet resourceSetImpl qui contiendra une ressource EMF (notre modÃ¨le)
		ResourceSet resSet = new ResourceSetImpl();
		ResourceSet resSetp = new ResourceSetImpl();
		
		// Charger la ressource simplePDL (notre modÃ¨le simplePDL) que l'on veut manipuler
		URI modelURI = URI.createURI("models/developpement.xmi");
		Resource resourceSimplePDL = resSet.getResource(modelURI, true);
		
		// Définir la ressource petriNet (notre modÃ¨le petriNet) que l'on veut créer
		URI modelURIp = URI.createURI("models/developpement_petriNet_java.xmi");
		Resource resourcePetriNet = resSetp.createResource(modelURIp);
				
		// La fabrique pour fabriquer les Ã©lÃ©ments de PetriNet
		myFactory = PetrinetFactory.eINSTANCE;	
		
		// RÃ©cupÃ©rer le premier Ã©lÃ©ment du modÃ¨le simplePDL (Ã©lÃ©ment racine)
		Process process = (Process) resourceSimplePDL.getContents().get(0);
		
		//Créer l'élément PetriNet
		petriNet = myFactory.createPetriNet();
		petriNet.setName(process.getName());
		
		// Ajouter le PetriNet dans le modÃ¨le
		resourcePetriNet.getContents().add(petriNet);
		
		//Transformer les workDefinitions en Petrinet
		for (Object o : process.getProcessElements()) {
			//Transformer les éléments en Petrinet
			if (o instanceof WorkDefinition) {
				transformWD ((WorkDefinition) o);
			} else if (o instanceof WorkSequence) {
				transformWS ((WorkSequence) o);
			} else if (o instanceof Ressource) {
				transformR ((Ressource) o);
			}
		}
		
		// Sauver la ressource petriNet créée
	    try {
	    	resourcePetriNet.save(Collections.EMPTY_MAP);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private static void transformWD (WorkDefinition wd) {
		// Places d'une WorkDefinition
		Place p_ready = myFactory.createPlace();
		p_ready.setName(wd.getName() + "_ready");
		p_ready.setNBjeton(1);
		p_ready.setNet(petriNet);
		petriNet.getPlaces().add(p_ready);
		
		Place p_started = myFactory.createPlace();
		p_started.setName(wd.getName() + "_started");
		p_started.setNet(petriNet);
		petriNet.getPlaces().add(p_started);
		
		Place p_running = myFactory.createPlace();
		p_running.setName(wd.getName() + "_running");
		p_running.setNet(petriNet);
		petriNet.getPlaces().add(p_running);
		
		Place p_finished = myFactory.createPlace();
		p_finished.setName(wd.getName() + "_finished");
		p_finished.setNet(petriNet);
		petriNet.getPlaces().add(p_finished);
		
		// Transitions d'une WorkDefinition
		Transition t_starts = myFactory.createTransition();
		t_starts.setName(wd.getName() + "_starts");
		t_starts.setNet(petriNet);
		petriNet.getTransitions().add(t_starts);
		
		Transition t_finishes = myFactory.createTransition();
		t_finishes.setName(wd.getName() + "_finishes");
		t_finishes.setNet(petriNet);
		petriNet.getTransitions().add(t_finishes);
		
		// Arcs d'une WorkDefinition
		Arc a_re2s = myFactory.createArc();
		a_re2s.setName(p_ready.getName() + " --> " + t_starts.getName());
		a_re2s.setTransition(t_starts);
		a_re2s.setPlace(p_ready);
		a_re2s.setType(ArcType.PLACE2_TRANSITION);
		a_re2s.setNature(ArcNature.NORMAL);
		a_re2s.setNBjeton(1);
		a_re2s.setNet(petriNet);
		petriNet.getArcs().add(a_re2s);
		
		Arc a_s2s = myFactory.createArc();
		a_s2s.setName(t_starts.getName() + " --> " + p_started.getName());
		a_s2s.setTransition(t_starts);
		a_s2s.setPlace(p_started);
		a_s2s.setType(ArcType.TRANSITION2_PLACE);
		a_s2s.setNature(ArcNature.NORMAL);
		a_s2s.setNBjeton(1);
		a_s2s.setNet(petriNet);
		petriNet.getArcs().add(a_s2s);
		
		Arc a_s2ru = myFactory.createArc();
		a_s2ru.setName(t_starts.getName() + " --> " + p_running.getName());
		a_s2ru.setTransition(t_starts);
		a_s2ru.setPlace(p_running);
		a_s2ru.setType(ArcType.TRANSITION2_PLACE);
		a_s2ru.setNature(ArcNature.NORMAL);
		a_s2ru.setNBjeton(1);
		a_s2ru.setNet(petriNet);
		petriNet.getArcs().add(a_s2ru);
		
		Arc a_ru2f = myFactory.createArc();
		a_ru2f.setName(p_running.getName() + " --> " + t_finishes.getName());
		a_ru2f.setTransition(t_finishes);
		a_ru2f.setPlace(p_running);
		a_ru2f.setType(ArcType.PLACE2_TRANSITION);
		a_ru2f.setNature(ArcNature.NORMAL);
		a_ru2f.setNBjeton(1);
		a_ru2f.setNet(petriNet);
		petriNet.getArcs().add(a_ru2f);
		
		Arc a_f2f = myFactory.createArc();
		a_f2f.setName(t_finishes.getName() + " --> " + p_finished.getName());
		a_f2f.setTransition(t_finishes);
		a_f2f.setPlace(p_finished);
		a_f2f.setType(ArcType.TRANSITION2_PLACE);
		a_f2f.setNature(ArcNature.NORMAL);
		a_f2f.setNBjeton(1);
		a_f2f.setNet(petriNet);
		petriNet.getArcs().add(a_f2f);
	}
	
	private static void transformWS (WorkSequence ws) {
		Arc arc = myFactory.createArc();
		arc.setName("WorkSequence " + ws.getPredecessor().getName() + " --" + ws.getLinkType().toString() + "--> " + ws.getSuccessor().getName());
		if (ws.getLinkType() == WorkSequenceType.START_TO_START || ws.getLinkType() == WorkSequenceType.FINISH_TO_START) {
			for (Transition t : petriNet.getTransitions()) {
				if (t.getName().equals(ws.getSuccessor().getName() + "_starts")) {
					arc.setTransition(t);
				}
			}
		} else {
			for (Transition t : petriNet.getTransitions()) {
				if (t.getName().equals(ws.getSuccessor().getName() + "_finishes")) {
					arc.setTransition(t);
				}
			}
		}
		if (ws.getLinkType() == WorkSequenceType.START_TO_START || ws.getLinkType() == WorkSequenceType.START_TO_FINISH) {
			for (Place p : petriNet.getPlaces()) {
				if (p.getName().equals(ws.getPredecessor().getName() + "_started")) {
					arc.setPlace(p);
				}
			}
		} else {
			for (Place p : petriNet.getPlaces()) {
				if (p.getName().equals(ws.getPredecessor().getName() + "_finished")) {
					arc.setPlace(p);
				}
			}
		}
		arc.setType(ArcType.PLACE2_TRANSITION);
		arc.setNature(ArcNature.READ);
		arc.setNBjeton(1);
		arc.setNet(petriNet);
		petriNet.getArcs().add(arc);
	}

	private static void transformR (Ressource r) {
		Place ressource = myFactory.createPlace();
		ressource.setName("Ressource_" + r.getName());
		ressource.setNBjeton(r.getQMax());
		ressource.setNet(petriNet);
		petriNet.getPlaces().add(ressource);
		
		// Créer les utilisations de la ressource
		for (Utilisation u : r.getUtilisations()) {
			Arc a_u2starts = myFactory.createArc();
			a_u2starts.setName(u.getRessource().getName() + " --" + u.getNb() + " --> " + u.getWorkdefinition().getName() + "_starts");
			for (Transition t : petriNet.getTransitions()) {
				if (t.getName().equals(u.getWorkdefinition().getName() + "_starts")) {
					a_u2starts.setTransition(t);
				}
			}
			a_u2starts.setPlace(ressource);
			a_u2starts.setType(ArcType.PLACE2_TRANSITION);
			a_u2starts.setNature(ArcNature.NORMAL);
			a_u2starts.setNBjeton(u.getNb());
			a_u2starts.setNet(petriNet);
			petriNet.getArcs().add(a_u2starts);
			
			Arc a_f2f = myFactory.createArc();
			a_f2f.setName(u.getWorkdefinition().getName() + " --" + u.getNb() + "--> " + u.getRessource().getName());
			for (Transition t : petriNet.getTransitions()) {
				if (t.getName().equals(u.getWorkdefinition().getName() + "_finishes")) {
					a_f2f.setTransition(t);
				}
			}
			a_f2f.setPlace(ressource);
			a_f2f.setType(ArcType.TRANSITION2_PLACE);
			a_f2f.setNature(ArcNature.NORMAL);
			a_f2f.setNBjeton(u.getNb());
			a_f2f.setNet(petriNet);
			petriNet.getArcs().add(a_f2f);
		}
		
	}
	
}

