class Lobby{
    int roomNumber;
    String myName;
    int updateTimer = 0;
    ArrayList<PlayerData> playerDataList = new ArrayList<PlayerData>();
    Button startButton = new Button(width/2 - 50, height/2 + 100, 100, 50, "Start");
    Button backButton = new Button(50, 50, 100, 50, "Back");
    Alert alert = new Alert("", width/2, 50);
    RoomData[] roomData = {
        new RoomData(0, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(1, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(2, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(3, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(4, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(5, 0, false, 2, new ArrayList<PlayerData>())
     };

    Lobby(int roomNumber, ArrayList<PlayerData> playerDataList, String myName){
        this.roomNumber = roomNumber;
        this.playerDataList = playerDataList;
        this.myName = myName;
    }
    void addPlayer(PlayerData playerData){
        playerDataList.add(playerData);
    }
    void removePlayer(PlayerData playerData){
        playerDataList.remove(playerData);
    }
    void update(){
        updateTimer++;
        if(updateTimer % 60 == 0){
            getRoomData();
            if(roomData[roomNumber].isPlaying){
                startGame();
            }
        }
    }
    void display(){
        background(255);
        fill(0);
        textSize(32);
        textAlign(CENTER);
        text("Room " + roomNumber + "  " + roomData[roomNumber].playerCount + " / " + roomData[roomNumber].maxPlayerCount, width/2, 200);
        ArrayList<PlayerData> players = roomData[roomNumber].getPlayers();
        for(int i = 0; i < players.size(); i++){
            text(players.get(i).name, width/2, 300 + 40*i);
        }
        textAlign(LEFT);
        startButton.display(false);
        backButton.display(false);
        alert.display();
    }
    void mouseClicked(){
        if(startButton.checkClick(mouseX, mouseY)){
            playerDataList = roomData[roomNumber].getPlayers();
            if(playerDataList.size() < 2){
                alert.setText("You need at least 2 players to start the game");
                return;
            }
            startGame();
        }
        if(backButton.checkClick(mouseX, mouseY)){
            exitRoom(roomNumber, myName);
            multiMenu = new MultiMenu();
            inLobby = false;
            inMultiMenu = true;
        }
    }
    void startGame(){
        ArrayList<PlayerData> playerDataList = roomData[roomNumber].getPlayers();
        game = new MultiGame(roomNumber, playerDataList, myName);
        isPlaying(roomNumber);
        inLobby = false;
        inGame = true;
    }

    void exitRoom(int roomNumber, String playerName){
        PostRequest post = new PostRequest(URL + "/exit" + "/" + roomNumber + "/" + playerName);
        post.send();

    }
    void isPlaying(int roomNumber){
        PostRequest post = new PostRequest(URL + "/isPlaying" + "/" + roomNumber + "/" + "true");
        post.send();
    }
    private boolean getRoomData(){
        GetRequest get = new GetRequest(URL + "/rooms");
        get.send();
        // println(get.getContent());

        // データが取得できた場合
        if(get.getContent() != null){
            // StringからJSONArrayに変換
            JSONArray jsonArray = parseJSONArray(get.getContent());

            //　各Roomに対して処理
            for(int i=0; i<jsonArray.size(); i++){
                // i番目のRoomのデータを取得
                JSONObject jsonObject = jsonArray.getJSONObject(i);

                int roomId = jsonObject.getInt("roomId");
                int playerCount = jsonObject.getInt("playerCount");
                boolean isPlaying = jsonObject.getBoolean("isPlaying");
                int maxPlayerCount = jsonObject.getInt("maxPlayerCount");
                ArrayList<PlayerData> playerData = new ArrayList<PlayerData>(playerCount);

                JSONArray players = jsonObject.getJSONArray("playerList");
                for(int j=0; j<playerCount; j++){
                    JSONObject player = players.getJSONObject(j);
                    String name = player.getString("name");
                    int score = player.getInt("score");
                    int roomIdPlayer = player.getInt("roomId");
                    playerData.add(new PlayerData(name, roomIdPlayer, score));
                }

                // RoomDataを作成
                roomData[i] = new RoomData(roomId, playerCount, isPlaying, maxPlayerCount, playerData);
            }
            return true;
        }else{
            println("Failed to get room data");
            return false;
        }
    }
}