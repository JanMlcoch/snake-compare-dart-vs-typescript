part of game;

class Table{
  static List<int> size = [30,30];
  static List<int> pointSize = [10,10];
  List<FoodPoint> foods = [];
  DivElement htmlContainer;
  Game game;

  Table(this.game){
    setHtmlContainer();
    addRandomFood();
  }

  void addRandomFood() {
    int x = new math.Random().nextInt(Table.size[0]);
    int y = new math.Random().nextInt(Table.size[1]);
    if(this.getFoodOnCoo([x,y]) != null){
      this.addRandomFood();
      return;
    }
    if(game.snake != null && isSnakeOnCoo([x,y])){
      this.addRandomFood();
      return;
    }
    addFood(x, y);
  }

  void setHtmlContainer(){
    htmlContainer = querySelector("#gameContainer");
    int x = Table.size[0] * Table.pointSize[0];
    int y = Table.size[1] * Table.pointSize[1];
    htmlContainer.style
      ..width = "${x}px"
      ..height = "${y}px";
  }

  void addFood(int x, int y){
    FoodPoint food = new FoodPoint([x,y], 1);
    foods.add(food);
    addPointIntoContainer(food);
  }

  void ateFood(FoodPoint food){
    removePointFromContainer(food);
    foods.remove(food);
    game.updateScore(food);
    addRandomFood();
  }

  void addPointIntoContainer(Point point){
    htmlContainer.append(point.htmlElement);
  }

  void removePointFromContainer(Point point){
    point.removeElement();
  }

  FoodPoint getFoodOnCoo(List<int> coo){
    for(FoodPoint food in foods){
      if(food.coordinates[0] == coo[0] && food.coordinates[1] == coo[1]){
        return food;
      }
    }
    return null;
  }

  bool isSnakeOnCoo(List<int> coo){
    for(Point snake in game.snake.snakeBody){
      if(snake.coordinates[0] == coo[0] && snake.coordinates[1] == coo[1]){
        return true;
      }
    }
    return false;
  }

  void clearTable(){
    htmlContainer.setInnerHtml('');
  }

  void resetTable() {
    clearTable();
    addRandomFood();
  }


}

class Point{
  List<int> coordinates;
  DivElement htmlElement;
  static int iterator = 0;

  Point(this.coordinates){
    createElement();
  }

  createElement(){
    htmlElement = new DivElement()..id = (Point.iterator++).toString();
    htmlElement.style
        ..width = "${Table.pointSize[0]}px"
        ..height = "${Table.pointSize[1]}px"
        ..left = "${Table.pointSize[0] * coordinates[0]}px"
        ..top = "${Table.pointSize[1] * coordinates[1]}px";
  }

  void removeElement() {
    htmlElement.remove();
  }

}

class FoodPoint extends Point{
  int value;

  FoodPoint(List<int> coordinates, this.value) : super(coordinates){
    htmlElement.classes.add("food");
  }

}