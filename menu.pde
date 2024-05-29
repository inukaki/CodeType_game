class Menu {
    int singleX, singleY, singleWidth, singleHeight;
    int multiX, multiY, multiWidth, multiHeight;
    Button singleButton, multiButton, settingButton;


    Menu() {
        singleX = width / 2 - 50;
        singleY = height / 2 - 25;
        singleWidth = 100;
        singleHeight = 50;
        multiX = width / 2 - 50;
        multiY = height / 2 + 50;
        multiWidth = 100;
        multiHeight = 50;
        singleButton = new Button(singleX, singleY, singleWidth, singleHeight, "Single");
        multiButton = new Button(multiX, multiY, multiWidth, multiHeight, "Multi");
        settingButton = new Button(width / 2 - 50 , height / 2 +125, 100, 50, "Setting");
    }

    void display() {
        background(200);
        fill(0);
        textAlign(CENTER, CENTER);
        textSize(48);
        text("Typing Game", width / 2, height / 4);
        
        // ボタンを描画
        singleButton.display(false);
        multiButton.display(false);
        settingButton.display(false);
    }

    boolean checkSingleClick(float mouseX, float mouseY) {
        return singleButton.checkClick(mouseX, mouseY);
    }
    boolean checkMultiClick(float mouseX, float mouseY) {
        return multiButton.checkClick(mouseX, mouseY);
    }

    void mouseClicked() {
        if (checkSingleClick(mouseX, mouseY)) {
            game = new Game();
            inGame = true;
            inMenu = false;
        }
        if (checkMultiClick(mouseX, mouseY)) {
            multiMenu = new MultiMenu();
            inMultiMenu = true;
            inMenu = false;
        }
        if(settingButton.checkClick(mouseX, mouseY)){
            setting = new Setting();
            inSetting = true;
            inMenu = false;
        }
    }
}
