/**
 * Created by Crat on 14.02.2017.
 */

class Table{
    static size: [number, number] = [30,30];
    static pointSize: [number, number] = [10,10];
    foods: FoodPoint[] = [];
    htmlContainer: HTMLElement;
    game: Game;

    constructor(game: Game){
        this.game = game;
        this.setHtmlContainer();
        this.addRandomFood();
        console.log("add food on constructor");
    }

    addRandomFood(){
        let x = Math.floor(Math.random() * Table.size[0]);
        let y = Math.floor(Math.random() * Table.size[1]);
        if(this.getFoodOnCoo([x,y]) != null){
            this.addRandomFood();
            return;
        }
        if(this.game.snake != null && this.isSnakeOnCoo([x,y])){
            this.addRandomFood();
            return;
        }
        this.addFood(x, y);
    }

    setHtmlContainer(){
        this.htmlContainer = document.getElementById("gameContainer");
        let x: number = Table.size[0] * Table.pointSize[0];
        let y: number = Table.size[1] * Table.pointSize[1];
        this.htmlContainer.style.width = x+"px";
        this.htmlContainer.style.height = y+"px";
    }

    addFood(x: number, y: number){
        let food = new FoodPoint([x,y], 1);
        this.foods.push(food);
        this.addPointIntoContainer(food);
    }

    ateFood(food: FoodPoint){
        this.removePointFromContainer(food);
        let first = this.foods.slice(0, this.foods.indexOf(food));
        let last = this.foods.slice(this.foods.indexOf(food)+1, this.foods.length);
        this.foods = [...first,...last];
        // delete this.foods[this.foods.indexOf(food)];
        this.game.updateScore(food);
        this.addRandomFood();
    }

    addPointIntoContainer(point: Point){
        this.htmlContainer.appendChild(point.htmlElement);
    }

    removePointFromContainer(point: Point){
        point.removeElement();
    }

    getFoodOnCoo(coo: [number, number]): any{
        for(let food of this.foods){
            if(food.coordinates[0] == coo[0] && food.coordinates[1] == coo[1]){
                return food;
            }
        }
        return null;
    }

    isSnakeOnCoo(coo: [number, number]): boolean{
        for(let snake of this.game.snake.snakeBody){
            if(snake.coordinates[0] == coo[0] && snake.coordinates[1] == coo[1]){
                return true;
            }
        }
        return false;
    }

    clearTable(){
        this.htmlContainer.innerHTML = "";
    }

    resetTable(){
        this.clearTable();
        this.addRandomFood();
    }
}

class Point{
    coordinates: [number, number];
    htmlElement: HTMLElement;
    static iterator: number = 0;

    constructor(_coordinates: [number, number]){
        this.coordinates = _coordinates;

        this.createElement();
    }

    createElement() {
        this.htmlElement = document.createElement('div');
        this.htmlElement.id = (Point.iterator++).toString();
        this.htmlElement.style.width = Table.pointSize[0]+"px";
        this.htmlElement.style.height = Table.pointSize[1]+"px";
        this.htmlElement.style.left = Table.pointSize[0] * this.coordinates[0]+"px";
        this.htmlElement.style.top = Table.pointSize[1] * this.coordinates[1]+"px";
    }

    removeElement(){
        this.htmlElement.remove();
    }
}

class FoodPoint extends Point{
    value: number;

    constructor(_coordinates: [number, number], _value: number){
        super(_coordinates);
        this.value = _value;
        this.htmlElement.classList.add("food");
    }
}