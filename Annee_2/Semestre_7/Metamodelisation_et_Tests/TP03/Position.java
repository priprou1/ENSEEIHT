import lombok.*;

/** DÃ©finir une position.  */
@Data
@Value
public class Position {
	private int x;
	private int y;
/*
	public Position(int x, int y) {
		this.x = x;
		this.y = y;
		System.out.println("...appel à Position(" + x + "," + y + ")" + " --> " + this);
	}*/
/*
	public int getX() {
		return this.x;
	}

	public int getY() {
		return this.y;
	}*/

	@Override public String toString() {
		return super.toString() + "(" + x + "," + y + ")";
	}

	/*@Override public boolean equals(Object o) {
		Position p = (Position) o;
		return (this.x == p.getX() && this.y == p.getY());
	}*/
}
