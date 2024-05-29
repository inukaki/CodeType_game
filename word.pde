class Word {
    String text;
    String translation;
    float x = width /2 , y = height / 2 - 50;
    boolean matched;
    TimeBar timeBar;
    int score;


    Word(String text, String translation, int score) {
        this.text = text;
        this.translation = translation;
        this.score = score;
        this.matched = false;
        this.timeBar = new TimeBar(20);
    }

    String getText() {
        return text;
    }

    void update() {
        timeBar.update();
    }

    void display() {
        fill(0);
        textSize(24);
        textAlign(CENTER);
        text(translation, x, y - 40);
        // println(translation);
        textSize(32);
        text(text, x, y);
        textAlign(LEFT);
        timeBar.display(x, y + 70);
    }

    boolean checkMatch(String input) {
      if (input.equals(text)) {
          matched = true;
          return true;
      }
        return false;
    }
}
