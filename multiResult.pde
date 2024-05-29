class MultiResult extends Result{
    ArrayList<PlayerData> players;

    MultiResult(ArrayList<PlayerData> players){
        super(0);
        this.players = players;
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
}