class Game {
    ArrayList<Word> words;
    // Word word;
    String currentInput;
    int score;
    int time = 60 * FPS;
    // addWord();

    Game() {
        words = new ArrayList<Word>();
        currentInput = "";
        score = 0;
        addWord();
        // word = getWord();
    }

    void addWord() {
        words.add(getWord());
    }

    // ゲーム終了時の処理
    void endGame() {
        // println("Game Over");
        result = new Result(score);
        inResult = true;
        inGame = false;
    }

    void update() {
        // wordsが要素を持たない場合
        // if (words.isEmpty()) return;
        time--;
        if (time == 0) endGame();
        Word w = words.get(0);
        // Word w = word;
        // println(words.get(0).text);
        // if(w == null) return;
        w.update();
        if (w.matched) {
          removeWord();
        }
    }

    void display() {
        background(255);
        Word w = words.get(0);
        // Word w = word;
        // if (w == null) return;
        w.display();
        fill(0);
        textSize(40);
        text("Score: " + game.score, 30, 50);
        text("Time: " + time / FPS, 30, 100);
        textAlign(LEFT);
        textSize(32);
        text(game.currentInput, width/2 - 200, height/2);
        textAlign(LEFT);
    }

    void removeWord() {
        words.remove(0);
        // word = getWord();
    }

    void checkInput() {
        Word w = words.get(0);
        // Word w = word;
        if (w.checkMatch(currentInput)) {
            score += w.score;
            currentInput = "";
            addWord();
            return;
        }
        currentInput = "";
    }

    void addInput(char c) {
        currentInput += c;
    }

    void removeLastInput() {
        if (currentInput.length() > 0) {
            currentInput = currentInput.substring(0, currentInput.length() - 1);
        }
    }
    Word getWord() {
        int count = 0;
        for(int i = 0; i < languages.length; i++) {
            if (languagesCheck.get(languages[i])) count++;
        }
        int choice = (int) random(count);
        if (count == 0) choice = (int) random(languages.length);
        // println("choice: " + choice + " count: " + count);
        
        for(int i = 0; i < languages.length; i++) {
            if (languagesCheck.get(languages[i]) || count == 0) {
                if (choice == 0) {
                    JSONArray words = loadJSONArray("./words/" + languages[i] + ".json");
                    int length = words.size();
                    JSONObject word = words.getJSONObject((int) random(length));
                    String text = word.getString("word");
                    int score = word.getInt("score");
                    String translation = word.getString("translation");
                    return new Word(text, translation, score);
                }
                choice--;
            }
        }
        return null;
    }

    void keyPressed() {
        if (key == BACKSPACE) {
            removeLastInput();
        } else if (key == ENTER) {
            checkInput();
        } else if (key != CODED){
            addInput(key);
        }
    }
}
