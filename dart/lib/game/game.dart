part of game;

enum Levels {Amateur, Normal, Profi}
enum Direction {Left, Right, Top, Down}
const Map<Levels, int> LevelsValues = const {Levels.Amateur: 100, Levels.Normal: 50, Levels.Profi: 30};


class Game{
  bool isStarted = false;
  bool isPaused = false;
  bool isAllowedWallCross = false;
  bool isAllowedSnakeCross = false;
  Table table;
  Snake snake;
  Levels difficulty = Levels.Amateur;
  Scores scores;
  Score actualScore;
  Timer timer;
  String boo = "boo";
  String foo = "foooo";
  String get loo => "loo";

  Game(){
    table = new Table(this);
    snake = new Snake(this);
    scores = new Scores();

    String mix = "my${boo}${foo.substring(0,3)}$loo"; // myboofooloo

    print(mix);
  }

  void startGame(){
    if(isStarted) return;
    actualScore = new Score((querySelector('#nick') as InputElement).value, 0);
    actualScore.score = 10;
    snake.direction = Direction.Right;
    isStarted = true;
    isPaused = false;
    setDifficulty();
    initTimer();
    document.onKeyDown.listen((KeyboardEvent event){
      switch (event.keyCode){
        case KeyCode.LEFT:
          if(this.snake.direction == Direction.Right) {
            return;
          }
          this.snake.direction = Direction.Left;
          break;
        case KeyCode.RIGHT:
          if(this.snake.direction == Direction.Left) {
            return;
          }
          this.snake.direction = Direction.Right;
          break;
        case KeyCode.UP:
          if(this.snake.direction == Direction.Down) {
            return;
          }
          this.snake.direction = Direction.Top;
          break;
        case KeyCode.DOWN:
          if(this.snake.direction == Direction.Top) {
            return;
          }
          this.snake.direction = Direction.Down;
          break;
      }
      initTimer();
      tick();
    });
  }

  void initTimer(){
    if(timer?.isActive == true){
      timer.cancel();
    }
    timer = new Timer.periodic(new Duration(milliseconds: LevelsValues[Levels.values[difficulty.index]]), (Timer timer){
      tick();
    });
  }

  void tick(){
    if (!isPaused && isStarted) {
      snake.move();
    }
  }

  void updateScore(FoodPoint food){
    actualScore.score += food.value;
    querySelector("#score").setInnerHtml(actualScore.score.toString());
  }

  void endGame(){
    isStarted = false;
    Element scoresElement = querySelector('#scores');
    scores.addNewScore(this.actualScore);
    scoresElement.setInnerHtml('');
    for(Score score in scores.sortedScores){
      SpanElement nameEl = new SpanElement()
        ..classes.add('name')
        ..setInnerHtml(score.nick);
      SpanElement scoreEl = new SpanElement()
        ..classes.add('score')
        ..setInnerHtml(score.score.toString());
      DivElement contEl = new DivElement()
        ..append(nameEl)
        ..append(scoreEl);
      scoresElement.append(contEl);
      table.resetTable();
      snake.resetSnake();
    }
  }

  void setDifficulty(){
    querySelectorAll('input[name="difficulty"]').forEach((RadioButtonInputElement input){
      if(!input.checked){
        return;
      }
      String difficulty = input.id;
      switch (difficulty){
        case 'difficulty-easy':
          this.difficulty = Levels.Amateur;
          break;
        case 'difficulty-normal':
          this.difficulty = Levels.Normal;
          break;
        case 'difficulty-hard':
          this.difficulty = Levels.Profi;
          break;
      }
    });
  }
}
