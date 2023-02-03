
import java.util.Observable;
import java.util.Observer;

public class VueChat implements Observer {

	private String vue;

	VueChat() {
		this.vue = "";
	}

	@Override
	public void update(Observable arg0, Object arg1) {
		this.vue = this.vue + "\n" + arg1.toString();
	}

}
