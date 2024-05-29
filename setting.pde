class Setting {
    Button backButton = new Button(50, 50, 100, 50, "Back");
    Button[] languageButtons = new Button[languages.length];

    Setting() {
        // ボタンを４＊３の形で配置
        for (int i = 0; i < languageButtons.length; i++) {
            languageButtons[i] = new Button(100 + 150 * (i % 4), 170 + 120 * (i / 4), 150, 50, languages[i]);
        }
    }

    void display() {
        // 背景
        background(255);
        // タイトル
        fill(0);
        textSize(40);
        textAlign(CENTER);
        text("Setting", width/2, 100);
        // 戻るボタン
        backButton.display(false);
        // 言語ボタン
        for (int i = 0; i < languageButtons.length; i++) {
            languageButtons[i].display(languagesCheck.get(languages[i]));
        }
    }

    void mouseClicked() {
        // 戻るボタン
        if (backButton.checkClick(mouseX, mouseY)) {
            menu = new Menu();
            inSetting = false;
            inMenu = true;
        }
        // 言語ボタン
        for (int i = 0; i < languageButtons.length; i++) {
            if (languageButtons[i].checkClick(mouseX, mouseY)) {
                boolean isCheck = languagesCheck.get(languages[i]);
                if(isCheck) languagesCheck.put(languages[i], false);
                else languagesCheck.put(languages[i], true);
            }
        }
    }
}