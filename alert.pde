class Alert {
    String text;
    int x, y;
    Alert(String text, int x, int y) {
        this.text = text;
        this.x = x;
        this.y = y;
    }
    void display() {
        // 赤色
        fill(255, 0, 0);
        textSize(20);
        textAlign(CENTER, CENTER);
        text(text, x, y);
        textAlign(LEFT, BASELINE);
    }

    void setText(String text) {
        this.text = text;
    }
}