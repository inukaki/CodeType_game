static class RoomData{
    int roomId;
    int playerCount;
    boolean isPlaying;
    int maxPlayerCount;
    ArrayList<PlayerData> players;

    public RoomData(int roomId, int playerCount, boolean isPlaying, int maxPlayerCount, ArrayList<PlayerData> players){
        this.roomId = roomId;
        this.playerCount = playerCount;
        this.isPlaying = isPlaying;
        this.maxPlayerCount = maxPlayerCount;
        this.players = players;
    }
    ArrayList<PlayerData> getPlayers(){
        return players;
    }
    void setPlayers(ArrayList<PlayerData> players){
        this.players = players;
    }
}