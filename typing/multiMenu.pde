class MultiMenu{
    Button[] buttons;
    Button backButton;
    Button reloadButton;
    float buttonWidth = 250;
    float buttonHeight = 100;
    Alert alert = new Alert("", width/2, 50);
    RoomData[] roomData = {
        new RoomData(0, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(1, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(2, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(3, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(4, 0, false, 2, new ArrayList<PlayerData>()),
        new RoomData(5, 0, false, 2, new ArrayList<PlayerData>())
     };
    String name = playerName;

    MultiMenu(){
        buttons = new Button[6];
        backButton = new Button(50, 50, 100, 50, "Back");
        reloadButton = new Button(width-150, 50, 100, 50, "Reload");
        getRoomData();

        for(int i=0; i<buttons.length; i++){
            RoomData room = roomData[i];
            String text = "Room " + i + " (" + room.playerCount + "/" + room.maxPlayerCount + ")\n";
            for(int j=0; j<room.players.size(); j++){
                text += room.players.get(j).name + "   ";
            }
            buttons[i] = new Button(width/2 - buttonWidth*1.25 + buttonWidth*(i%2)*1.5, height/2 - buttonHeight*1.2 + i/2 *buttonHeight*1.2, buttonWidth, buttonHeight, text);
        }
    }
    void display(){
        background(200);
        fill(0);
        textAlign(CENTER, CENTER);
        textSize(48);
        text("Typing Game", width / 2, height / 5);
        for(int i=0; i<buttons.length; i++){
            buttons[i].display(false);
        }
        backButton.display(false);
        reloadButton.display(false);
        alert.display();

        // name入力
        fill(0);
        textSize(24);
        text("your name : ", 100, height/2 + 270);
        text(name, 250, height/2 + 270);
    }

    void reload(){
        println("reload");
        getRoomData();
        
        for(int i=0; i<buttons.length; i++){
            RoomData room = roomData[i];
            String text = "Room " + i + " (" + room.playerCount + "/" + room.maxPlayerCount + ")\n";
            for(int j=0; j<room.players.size(); j++){
                text += room.players.get(j).name + "   ";
            }
            buttons[i].setText(text);
        }
    }
    void enterRoom(int roomNumber, String playerName){
        PostRequest post = new PostRequest(URL + "/enter" + "/" + roomNumber + "/" + playerName);
        post.send();
        roomData[roomNumber].players.add(new PlayerData(playerName, roomNumber, 0));
        roomData[roomNumber].playerCount++;
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
    void mouseClicked() {
        if(backButton.checkClick(mouseX, mouseY)){
            inMultiMenu = false;
            inMenu = true;
        }
        if(reloadButton.checkClick(mouseX, mouseY)){
            multiMenu.reload();
        }
        for(int i=0; i<buttons.length; i++){
            if(buttons[i].checkClick(mouseX, mouseY)){
                if(name.length() == 0){
                    alert.setText("Please enter your name");
                    return;
                }else if(roomData[i].playerCount >= roomData[i].maxPlayerCount){
                    alert.setText("Room is full");
                    return;
                }else if(roomData[i].players.contains(new PlayerData(name, i, 0))){
                    alert.setText("Name already exists. Please enter another name");
                    return;
                }
                enterRoom(i, name);
                // game = new MultiGame(i, roomData[i].players);
                lobby = new Lobby(i, roomData[i].players, name);
                inMultiMenu = false;
                inLobby = true;
            }
        }
    }
    void keyPressed(){
        if(key == BACKSPACE){
            if(name.length() > 0){
                name = name.substring(0, name.length()-1);
                playerName = name;
            }
        }else if(key == ENTER){
            // println("Enter");
        }else{
            name += key;
            playerName = name;
        }
    }
}