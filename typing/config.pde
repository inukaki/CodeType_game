
// シーン
Game game;
Menu menu;
MultiMenu multiMenu;
Lobby lobby;
Result result;
Setting setting;

// シーンフラグ
boolean inMenu = true;
boolean inMultiMenu = false;
boolean inGame = false;
boolean inLobby = false;
boolean inResult = false;
boolean inSetting = false;

// 環境変数
public final int FPS = 60;
public final int PORT = 8025;
public String IP ="10.2.253.237";
public String URL = "http://" + IP + ":" + PORT;

String playerName = "";
PFont font;


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
        put("Brainfuck", false);
    }
};
String[] languages = {"Java", "Python", "JavaScript", "C++", "C#", "Swift", "Kotlin", "Go", "Haskell", "TypeScript", "C", "Brainfuck"};
