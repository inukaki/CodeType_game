class Result {
    int score;
    Button topButton = new Button(50, 50, 100, 50, "Top");
    

    Result(int score) {
        this.score = score;
    }

    void display() {
        background(255);
        fill(0);
        textSize(32);
        textAlign(CENTER, CENTER);
        text("Score: " + score, width/2, height/2);
        textAlign(LEFT, BASELINE);
        topButton.display(false);
    }

    void mouseClicked() {
        if (topButton.checkClick(mouseX, mouseY)) {
            menu = new Menu();
            inMenu = true;
            inResult = false;
        }
    }

}