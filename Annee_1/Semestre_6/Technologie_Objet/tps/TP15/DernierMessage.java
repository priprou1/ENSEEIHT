import java.util.Observable;
import java.util.Observer;

public class DernierMessage implements Observer {

	@Override
	public void update(Observable arg0, Object arg1) {
		System.out.println("Dernier message : " + arg1.toString());
	}

}
