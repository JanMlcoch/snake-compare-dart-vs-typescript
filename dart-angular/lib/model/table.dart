part of model;

class Table {
  List<int> size = [30, 30];
  List<int> pointSize = [10, 10];
  List<FoodPoint> foods = [];

  int get width => size[0] * pointSize[0];
  int get height => size[1] * pointSize[1];

  void addRandomFood() {
    int x = new math.Random().nextInt(size[0]);
    int y = new math.Random().nextInt(size[1]);
    if(this.getFoodOnCoo([x,y]) != null){
      this.addRandomFood();
      return;
    }
//    if(game.snake != null && isSnakeOnCoo([x,y])){
//      this.addRandomFood();
//      return;
//    }
    addFood(x, y);
  }

  void addFood(int x, int y){
    FoodPoint food = new FoodPoint([x,y], 1);
    foods.add(food);
//    addPointIntoContainer(food);
  }

  FoodPoint getFoodOnCoo(List<int> coo){
    for(FoodPoint food in foods){
      if(food.coordinates[0] == coo[0] && food.coordinates[1] == coo[1]){
        return food;
      }
    }
    return null;
  }

  void resetTable() {
    foods.clear();
    addRandomFood();
  }
}


class Point{
  static int iterator = 0;
  List<int> coordinates;
  int id = iterator++;

  Point(this.coordinates);
}

class FoodPoint extends Point{
  static String foodClass = "food";
  int value;
  FoodPoint(List<int> coordinates, this.value) : super(coordinates){}
}

class SnakePoint extends Point{
  static String foodClass = "snake";

  SnakePoint(List<int> coordinates) : super(coordinates);
  SnakePoint.fromPoint(Point point) : super(point.coordinates);
}