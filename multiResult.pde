class MultiResult extends Result{
    ArrayList<PlayerData> players;
    int roomNumber;

    MultiResult(ArrayList<PlayerData> players, int roomNumber){
        super(0);
        this.players = players;
        this.roomNumber = roomNumber;
    }

    @Override
    void display(){
        background(255);
        fill(0);
        textSize(32);
        textAlign(CENTER);
        for(int i = 0; i < players.size(); i++){
            text(players.get(i).name + " score: " + players.get(i).score, width/2, height/3 + 50 + 50 * i);
        }
        textAlign(LEFT);
        topButton.display(false);
    }
    @Override
    void mouseClicked(){
        super.mouseClicked();
        if(topButton.checkClick(mouseX, mouseY)){
            for(int i = 0; i < players.size(); i++){
                exitRoom(roomNumber, players.get(i).getName());
                println("Player " + players.get(i).getName() + " has left the room");
            }
            isNotPlaying(roomNumber);
        }
    }

    void exitRoom(int roomNumber, String playerName){
        PostRequest post = new PostRequest("http://localhost:" + PORT + "/exit" + "/" + roomNumber + "/" + playerName);
        post.send();
    }
    
    void isNotPlaying(int roomNumber){
        PostRequest post = new PostRequest("http://localhost:" + PORT + "/isPlaying" + "/" + roomNumber + "/false");
        post.send();
    }
}