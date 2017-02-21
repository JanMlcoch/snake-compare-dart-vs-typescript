part of model;

class Snake {
  Table table;
  List<Point> snakeBody = [];
  Point nextPoint;
  Direction direction = Direction.Right;

  Snake(this.table) {
    initSnake(table.size[1] ~/ 2);
  }

  void initSnake(int tableMiddleY){
    addSnakePoint(0, tableMiddleY);
    addSnakePoint(1, tableMiddleY);
    addSnakePoint(2, tableMiddleY);
    nextPoint = new Point([3, tableMiddleY]);
  }

  void addSnakePoint(int x, int y){
    SnakePoint point = new SnakePoint([x,y]);
    snakeBody.add(point);
  }

  void addPointToSnake(Point point){
    SnakePoint snakePoint = new SnakePoint.fromPoint(point);
    snakeBody.add(snakePoint);
  }

  void resetSnake() {
    snakeBody.clear();
    direction = Direction.Right;
    initSnake(table.size[1] ~/ 2);
  }

}
