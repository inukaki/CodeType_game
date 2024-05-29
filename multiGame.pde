class MultiGame extends Game {
    int roomNumber;
    int updateTimer = 0;
    String myName;
    // ArrayList<PlayerData> players = new ArrayList<PlayerData>();
    RoomData[] roomData = {
        new RoomData(0, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(1, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(2, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(3, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(4, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(5, 0, false, 2, new ArrayList<PlayerData>())
     };

    MultiGame(int roomNumber, ArrayList<PlayerData> players, String myName) {
        super();
        this.roomNumber = roomNumber;
        // this.players = players;
        this.roomData[roomNumber].setPlayers(players);
        this.myName = myName;
    }

    @Override
    void update(){
        super.update();
        updateTimer++;
        ArrayList<PlayerData> players = roomData[roomNumber].getPlayers();
        if(updateTimer % 60 == 0){
            println("Update room data");
            getRoomData();
            ArrayList<PlayerData> newPlayers = roomData[roomNumber].getPlayers();
            println(newPlayers);
            setScore(roomNumber, myName, score);
        }
    }

    @Override
    void display(){
        super.display();
        
        textSize(40);
        textAlign(RIGHT);
        text("Room " + roomNumber, width - 30, 50);
        ArrayList<PlayerData> players = roomData[roomNumber].getPlayers();
        int count = 0;
        for(int i = 0; i < players.size(); i++){
            if(!players.get(i).getName().equals(myName)){
                count++;
                text(players.get(i).getName() + " : " + players.get(i).getScore(), width - 30, 50 + 50 * count);
            }
        }
    }

    @Override
    void endGame() {
        // super.endGame();
        ArrayList<PlayerData> players = roomData[roomNumber].getPlayers();
        result = new MultiResult(players);
        println(players.size());
        for(int i = 0; i < players.size(); i++){
            exitRoom(roomNumber, players.get(i).getName());
            println("Player " + players.get(i).getName() + " has left the room");
        }
        isNotPlaying(roomNumber);
        inGame = false;
        inResult = true;
    }

    void exitRoom(int roomNumber, String playerName){
        PostRequest post = new PostRequest("http://localhost:" + PORT + "/exit" + "/" + roomNumber + "/" + playerName);
        post.send();
    }
    
    void isNotPlaying(int roomNumber){
        PostRequest post = new PostRequest("http://localhost:" + PORT + "/isPlaying" + "/" + roomNumber + "/false");
        post.send();
    }

    void setScore(int roomNumber, String playerName, int score){
        PostRequest post = new PostRequest("http://localhost:" + PORT + "/score" + "/" + roomNumber + "/" + playerName + "/" + score);
        post.send();
    }
    
    private boolean getRoomData(){
        GetRequest get = new GetRequest("http://localhost:" + PORT + "/rooms");
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