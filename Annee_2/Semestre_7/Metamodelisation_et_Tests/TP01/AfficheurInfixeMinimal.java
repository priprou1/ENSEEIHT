/** Afficheur infixe, complètement parenthésé, d'une expression arithmétique.
  *
  * @author	Xavier Crégut
  * @version	$Revision$
  */
  public class AfficheurInfixeMinimal implements VisiteurExpression<String> {

	public String visiterAccesVariable(AccesVariable v) {
		return v.getNom();
	}

	public String visiterConstante(Constante c) {
		return String.valueOf(c.getValeur());
	}

	public String visiterExpressionBinaire(ExpressionBinaire e) {
        String s1, s2;

        if (e.getOperandeGauche().getClass().getName().equals("ExpressionBinaire")) {
            ExpressionBinaire eg = (ExpressionBinaire) e.getOperandeGauche();
            if (eg.getOperateur().accepter(this).equals("+") | eg.getOperateur().accepter(this).equals("-"))
                s1 = "(" + e.getOperandeGauche().accepter(this) + ")";
            else {
            s1 = e.getOperandeGauche().accepter(this);
            }
        } else {
            s1 = e.getOperandeGauche().accepter(this);
        }

        if (e.getOperandeDroite().getClass().getName().equals("ExpressionBinaire")) {
            ExpressionBinaire eg = (ExpressionBinaire) e.getOperandeDroite();
            if (eg.getOperateur().accepter(this).equals("+") | eg.getOperateur().accepter(this).equals("-"))
                s2 = "(" + e.getOperandeDroite().accepter(this) + ")";
            else {
            s2 = e.getOperandeDroite().accepter(this);
            }
        } else {
            s2 = e.getOperandeDroite().accepter(this);
        }


		return s1
			+ " " + e.getOperateur().accepter(this)
			+ " " + s2;
	}

	public String visiterAddition(Addition a) {
		return "+";
	}

	public String visiterMultiplication(Multiplication m) {
		return "*";
	}

	public String visiterSoustraction(Soustraction s) {
		return "-";
	}

	public String visiterExpressionUnaire(ExpressionUnaire e) {
		return "(" + e.getOperateur().accepter(this)
			+ " " + e.getOperande().accepter(this) + ")";
	}

	public String visiterNegation(Negation n) {
		return "-";
	}

}
