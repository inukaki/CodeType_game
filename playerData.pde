class PlayerData{
    String name;
    int score;
    int roomId;

    public PlayerData(String name,int roomId, int score){
        this.name = name;
        this.roomId = roomId;
        this.score = score;
    }

    String getName(){
        return name;
    }

    int getScore(){
        return score;
    }
}