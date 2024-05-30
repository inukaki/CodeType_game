import http.requests.*;

void setup() {
    size(800, 600);
    frameRate(FPS);
    font = createFont("Bahnschrift", 32);
    textFont(font);
    menu = new Menu();
}

void draw() {
    if (inMenu) {
        menu.display();
    }else if(inMultiMenu){
        multiMenu.display();
    }else if(inLobby){
        lobby.update();
        lobby.display();
    }else if (inGame) {
        game.update();
        game.display();
    }else if(inResult){
        result.display();
    }else if(inSetting){
        setting.display();
    }
}

void keyPressed() {
  if(inGame) game.keyPressed();
  else if(inMultiMenu) multiMenu.keyPressed();
}

void mouseClicked() {
  if(inMenu) menu.mouseClicked();
  else if(inMultiMenu) multiMenu.mouseClicked();
  else if(inResult) result.mouseClicked();
  else if(inLobby) lobby.mouseClicked();
  else if(inSetting) setting.mouseClicked();
}