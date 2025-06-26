class Button {
    float x, y, w, h;
    String text;
    boolean clicked = false;

    Button(float x, float y, float w, float h, String text) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.text = text;
    }
    void display(boolean clicked) {
        fill(255);
        stroke(0);
        if (clicked) {
            fill(200);
        }
        rect(x, y, w, h);
        fill(0);
        textSize(24);
        textAlign(CENTER, CENTER);
        text(text, x + w / 2, y + h / 2);
        textAlign(LEFT, BASELINE);
    }

    boolean checkClick(float mouseX, float mouseY) {
        if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
            clicked = true;
            return true;
        }
        return false;
    }
    void setText(String text) {
        this.text = text;
    }
}