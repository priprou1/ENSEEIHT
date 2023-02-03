package src.affichagePartie;

import javax.swing.*;
import java.awt.*;

@SuppressWarnings("serial")
public class ResizeFontLabel extends JLabel {

    public ResizeFontLabel(String text) {
        super(text);
    }

    public void updateFont() {
        Font font = this.getFont();
        String text = this.getText();

        int stringWidth = this.getFontMetrics(font).stringWidth(text);
        int componentWidth = this.getWidth();

        // Find out how much the font can grow in width.
        double widthRatio = (double)componentWidth / (double)stringWidth;

        int newFontSize = (int)(font.getSize() * widthRatio);
        int componentHeight = this.getHeight();

        // Pick a new font size so it will not be larger than the height of label.
        newFontSize = Math.min(newFontSize, componentHeight);

        // Set the label's font size to the newly determined size.
        this.setFont(new Font(font.getName(), Font.PLAIN, newFontSize));
    }
    
}