import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:dart/model/library.dart';

@Injectable()
class GameService{
  Table table;
  Scores scores;
  Game game;

  bool isStarted = false;
  bool isPaused = false;
  bool isAllowedWallCross = false;
  bool isAllowedSnakeCross = false;

  GameService(){
    table = new Table();
    scores = new Scores();
    game = new Game(table);
  }

  void startGame(){
    if(isStarted) return;
    isStarted = true;
    game.initNewGame();
    table.resetTable();
  }

  void endGame(){
    isStarted = false;
    scores.addNewScore(game.actualScore);
  }


  void updateScore(FoodPoint food){
    game.actualScore.score += food.value;
  }

  void ateFood(FoodPoint food){
    table.foods.remove(food);
    updateScore(food);
    table.addRandomFood();
  }
}