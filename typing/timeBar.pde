class TimeBar{

    private int startTime;
    private int time;
    private int maxWidth = 100;
    private int width = maxWidth;
    private int height = 20;

    TimeBar(int startTime){
        this.startTime = startTime * FPS;
        time = this.startTime;
    }
    void display(float x, float y){
        fill(0, 0, 0);
        rect(x, y, maxWidth, height);
        fill(255, 0, 0);
        rect(x, y, width, height);
    }
    void update(){
        time--;
        width = time * maxWidth / startTime;
        if(time == 0){
            time = startTime;
            width = maxWidth;
            game.addWord();
            game.removeWord();
            game.currentInput = "";
        }
    }
}