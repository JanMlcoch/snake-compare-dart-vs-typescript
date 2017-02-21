part of model;

enum Levels {Amateur, Normal, Profi}
enum Direction {Left, Right, Top, Down}
const Map<Levels, int> LevelsValues = const {Levels.Amateur: 100, Levels.Normal: 50, Levels.Profi: 30};

class Game {
  Snake snake;
  Table table;
  Levels difficulty = Levels.Amateur;
  Score actualScore;

  Game(this.table){
    snake = new Snake(table);
    actualScore = new Score();
    difficulty = Levels.Normal;
  }

  void initNewGame(){
    actualScore = new Score();
    snake.direction = Direction.Right;
    snake.resetSnake();
  }
}