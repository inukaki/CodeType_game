import websockets.*;
import http.requests.*;
PFont font;
WebsocketClient wsc;
Game game;
Menu menu;
MultiMenu multiMenu;
Lobby lobby;
Result result;
Setting setting;

public final int FPS = 60;
public final int PORT = 8025;

boolean inMenu = true;
boolean inMultiMenu = false;
boolean inGame = false;
boolean inLobby = false;
boolean inResult = false;
boolean inSetting = false;

// プログラミング言語とbooleanの組のデータ
HashMap<String, Boolean> languagesCheck = new HashMap<String, Boolean>(){
    {
        put("Java", false);
        put("Python", false);
        put("JavaScript", false);
        put("C++", false);
        put("C#", false);
        put("Swift", false);
        put("Kotlin", false);
        put("Go", false);
        put("Haskell", false);
        put("TypeScript", false);
        put("C", false);
        put("Brainfuck", false)
    }
};
String[] languages = {"Java", "Python", "JavaScript", "C++", "C#", "Swift", "Kotlin", "Go", "Haskell", "TypeScript", "C", "brainfuck"};


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
// int now;
// boolean newEllipse;

// void setup(){
//   size(200,200);
  
//   newEllipse=true;
  
//   //Here I initiate the websocket connection by connecting to "ws://localhost:8025/john", which is the uri of the server.
//   //this refers to the Processing sketch it self (you should always write "this").
//   wsc= new WebsocketClient(this, "ws://localhost:8025/john");
//   now=millis();
// }

// void draw(){
//     //Here I draw a new ellipse if newEllipse is true
//   if(newEllipse){
//     ellipse(random(width),random(height),10,10);
//     newEllipse=false;
//   }
    
//     //Every 5 seconds I send a message to the server through the sendMessage method
//   if(millis()>now+5000){
//     wsc.sendMessage("Client message");
//     now=millis();
//   }
// }

// //This is an event like onMouseClicked. If you chose to use it, it will be executed whenever the server sends a message 
// void webSocketEvent(String msg){
//  println(msg);
//  newEllipse=true;
// }