import java.util.Map;

public class EvaluateurExpression implements VisiteurExpression<Integer> {

	private Map<String,Integer> vars;

	public EvaluateurExpression(Map<String,Integer> vars) {
		this.vars = vars;
	} 

	public Integer visiterAccesVariable(AccesVariable v) {
		return vars.get(v.getNom());
	}

	public Integer visiterConstante(Constante c) {
		return Integer.valueOf(c.getValeur());
	}

	public Integer visiterExpressionBinaire(ExpressionBinaire e) {
		switch (e.getOperateur().accepter(this)) {
			case 0:
				return e.getOperandeGauche().accepter(this) + e.getOperandeDroite().accepter(this);
			case 1:
				return e.getOperandeGauche().accepter(this) - e.getOperandeDroite().accepter(this);
			case 2:
				return e.getOperandeGauche().accepter(this) * e.getOperandeDroite().accepter(this);
			default:
				return 0;
		}
	}

	public Integer visiterAddition(Addition a) {
		return 0;
	}

    public Integer visiterSoustraction(Soustraction a) {
		return 1;
	}

	public Integer visiterMultiplication(Multiplication m) {
		return 2;
	}

	public Integer visiterExpressionUnaire(ExpressionUnaire e) {
		switch (e.getOperateur().accepter(this)) {
			case 0:
				return -e.getOperande().accepter(this);
			default:
				return e.getOperande().accepter(this);
		}
	}

	public Integer visiterNegation(Negation n) {
		return 0;
	}

}
