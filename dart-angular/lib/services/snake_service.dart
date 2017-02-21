import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';

import 'package:dart/services/game_service.dart';
import 'package:dart/model/library.dart';

@Injectable()
class SnakeService{
  final GameService gameService;
  Snake get snake => gameService.game.snake;
  Timer timer;

  SnakeService(this.gameService){
    bindKeyboard();
    initTimer();
  }

  void initTimer(){
    if(timer?.isActive == true){
      timer.cancel();
    }
    Duration interval = new Duration(milliseconds: LevelsValues[gameService.game.difficulty]);
    timer = new Timer.periodic(interval, (Timer timer){
      if(interval.inMilliseconds != LevelsValues[gameService.game.difficulty]){
        initTimer();
      }
      tick();
    });
  }

  void tick(){
    if (!gameService.isPaused && gameService.isStarted) {
      move();
    }
  }

  void move(){
    if(resolveWallCollision()){
      if(gameService.isAllowedWallCross){
        goThroughWall();
      }else{
        collision();
      }
    }
    if(resolveSnakeCollision()){
      if(!gameService.isAllowedSnakeCross){
        collision();
      }
      return;
    }
    if(snake.nextPoint is FoodPoint){
      gameService.ateFood(snake.nextPoint);
    }else{
      removeLastBodyPoint();
    }
    snake.addPointToSnake(snake.nextPoint);
    resolveNextPoint();
  }


  void resolveNextPoint(){
    List<int> snakeHeadCoo = snake.snakeBody.last.coordinates;
    List<int> newCoo = [];
    switch (snake.direction){
      case Direction.Right:
        newCoo = [snakeHeadCoo[0]+1,snakeHeadCoo[1]];
        break;
      case Direction.Left:
        newCoo = [snakeHeadCoo[0]-1,snakeHeadCoo[1]];
        break;
      case Direction.Top:
        newCoo = [snakeHeadCoo[0],snakeHeadCoo[1]-1];
        break;
      case Direction.Down:
        newCoo = [snakeHeadCoo[0],snakeHeadCoo[1]+1];
        break;
    }
    if(gameService.table.getFoodOnCoo(newCoo) != null){
      snake.nextPoint = gameService.table.getFoodOnCoo(newCoo);
    }else{
      snake.nextPoint = new Point(newCoo);
    }
  }

  void removeLastBodyPoint(){
    Point last = snake.snakeBody.first;
//    gameService.table.removePointFromContainer(last);
    snake.snakeBody.remove(last);
  }

  bool resolveWallCollision(){
    bool horizontalCollision = snake.nextPoint.coordinates[0] >= gameService.table.size[0] || snake.nextPoint.coordinates[0] < 0;
    bool verticalCollision = snake.nextPoint.coordinates[1] >= gameService.table.size[1] || snake.nextPoint.coordinates[1] < 0;
    return horizontalCollision || verticalCollision;
  }

  bool resolveSnakeCollision(){
    return isSnakeOnCoo(snake.nextPoint.coordinates);
  }

  void goThroughWall(){
    List<int> coo;
    // Over right side
    if(snake.nextPoint.coordinates[0] >= gameService.table.size[0]){
      coo = [0, snake.nextPoint.coordinates[1]];
    }
    // Over left side
    else if(snake.nextPoint.coordinates[0] < 0){
      coo = [gameService.table.size[0] - 1, snake.nextPoint.coordinates[1]];
    }
    // Over bottom side
    else if(snake.nextPoint.coordinates[1] >= gameService.table.size[1]){
      coo = [snake.nextPoint.coordinates[0], 0];
    }
    // Over top side
    else{
      coo = [snake.nextPoint.coordinates[0], gameService.table.size[1] - 1];
      // this.collision();
    }
    Point mirrorPoint = new Point(coo);
    snake.addPointToSnake(mirrorPoint);
    removeLastBodyPoint();
    resolveNextPoint();
  }

  void collision(){
    gameService.endGame();
  }

  bool isSnakeOnCoo(List<int> coo){
    for(Point snake in snake.snakeBody){
      if(snake.coordinates[0] == coo[0] && snake.coordinates[1] == coo[1]){
        return true;
      }
    }
    return false;
  }

  void bindKeyboard(){
    document.onKeyDown.listen((KeyboardEvent event){
      switch (event.keyCode){
        case KeyCode.LEFT:
          if(snake.direction == Direction.Right) {
            return;
          }
          snake.direction = Direction.Left;
          break;
        case KeyCode.RIGHT:
          if(snake.direction == Direction.Left) {
            return;
          }
          snake.direction = Direction.Right;
          break;
        case KeyCode.UP:
          if(snake.direction == Direction.Down) {
            return;
          }
          snake.direction = Direction.Top;
          break;
        case KeyCode.DOWN:
          if(snake.direction == Direction.Top) {
            return;
          }
          snake.direction = Direction.Down;
          break;
      }
      initTimer();
      tick();
    });
  }
}