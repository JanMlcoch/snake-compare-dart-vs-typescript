part of game;

class Snake{
  List<Point> snakeBody = [];
  Point nextPoint;
  Direction direction = Direction.Right;
  Game game;

  Snake(this.game){
    initSnake();
  }

  void initSnake(){
    int middleY = Table.size[1] ~/ 2;
    Point a = getSnakePoint(0, middleY);
    Point b = getSnakePoint(1, middleY);
    Point c = getSnakePoint(2, middleY);
    nextPoint = new Point([3, middleY]);
  }

  Point getSnakePoint(int x, int y){
    Point point = new Point([x,y]);
    addPointToSnake(point);
    return point;
  }

  void move(){
    if(resolveWallCollision()){
      if(game.isAllowedWallCross){
        goThroughWall();
      }else{
        collision();
      }
    }
    if(resolveSnakeCollision()){
      if(!game.isAllowedSnakeCross){
        collision();
      }
      return;
    }
    if(nextPoint is FoodPoint){
      game.table.ateFood(nextPoint);
    }else{
      removeLastBodyPoint();
    }
    addPointToSnake(nextPoint);
    resolveNextPoint();
  }

  void addPointToSnake(Point point){
    point.htmlElement.classes.add("snake");
    snakeBody.add(point);
    game.table.addPointIntoContainer(point);
  }

  void goThroughWall(){
    List<int> coo;
    // Over right side
    if(nextPoint.coordinates[0] >= Table.size[0]){
      coo = [0, this.nextPoint.coordinates[1]];
    }
    // Over left side
    else if(nextPoint.coordinates[0] < 0){
      coo = [Table.size[0] - 1, this.nextPoint.coordinates[1]];
    }
    // Over bottom side
    else if(nextPoint.coordinates[1] >= Table.size[1]){
      coo = [nextPoint.coordinates[0], 0];
    }
    // Over top side
    else{
      coo = [nextPoint.coordinates[0], Table.size[1] - 1];
      // this.collision();
    }
    Point mirrorPoint = new Point(coo);
    addPointToSnake(mirrorPoint);
    removeLastBodyPoint();
    resolveNextPoint();
  }

  void resolveNextPoint(){
    List<int> snakeHeadCoo = snakeBody.last.coordinates;
    List<int> newCoo = [];
    switch (direction){
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
    if(game.table.getFoodOnCoo(newCoo) != null){
      nextPoint = game.table.getFoodOnCoo(newCoo);
    }else{
      nextPoint = new Point(newCoo);
    }
  }

  void removeLastBodyPoint(){
    Point last = snakeBody.first;
    game.table.removePointFromContainer(last);
    snakeBody.remove(last);
  }

  bool resolveWallCollision(){
    bool horizontalCollision = nextPoint.coordinates[0] >= Table.size[0] || nextPoint.coordinates[0] < 0;
    bool verticalCollision = nextPoint.coordinates[1] >= Table.size[1] || nextPoint.coordinates[1] < 0;
    return horizontalCollision || verticalCollision;
  }

  bool resolveSnakeCollision(){
    return game.table.isSnakeOnCoo(nextPoint.coordinates);
  }

  void collision(){
    game.endGame();
  }

  void resetSnake() {
    snakeBody.clear();
    direction = Direction.Right;
    initSnake();
  }

}