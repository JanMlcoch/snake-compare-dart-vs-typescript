/**
 * Created by Crat on 08.02.2017.
 */

enum Levels {Amateur = 100, Normal = 50, Profi = 30}
enum Direction {Left, Right, Top, Down}


class Game{
    table: Table;
    isStarted: boolean = false;
    difficulty: Levels = Levels.Amateur;
    scores: Scores = new Scores();
    isPaused: boolean = false;
    actualScore: Score;
    snake: Snake;
    timer: number;

    startGame() {
        this.table = new Table();
        this.snake = new Snake();
        this.actualScore = new Score(0);
        this.initTimer();
        document.onkeydown =  (event: KeyboardEvent) => {
            switch (event.keyCode){
                //Left
                case 37:
                    this.snake.direction = Direction.Left;
                    break;
                // Right
                case 39:
                    this.snake.direction = Direction.Right;
                    break;
                // Top
                case 38:
                    this.snake.direction = Direction.Top;
                    break;
                // Down
                case 40:
                    this.snake.direction = Direction.Down;
                    break;
            }
            this.initTimer();
            this.tick();
        };
    }

    initTimer(){
        if(this.timer != null){
            clearTimeout(this.timer);
            this.timer = null;
        }
        this.timer = setTimeout(() => this.tick(), this.difficulty);
    }

    tick(){
        if(!this.isPaused){
            this.snake.move();
        }
        this.initTimer();
    }
}

let game = new Game();

class Table{
    static size: [number, number] = [30,30];
    static pointSize: [number, number] = [10,10];
    foods: Point[] = [];
    htmlContainer: HTMLElement;

    constructor(){
        this.setHtmlContainer();
        this.addRandomFood();
    }

    addRandomFood(){
        let x = Math.floor(Math.random() * Table.size[0]);
        let y = Math.floor(Math.random() * Table.size[1]);
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
        let food = new Point([x,y], 1, true);
        this.foods.push(food);
        food.htmlElement.classList.add("food");
        this.addPointIntoContainer(food);
    }

    ateFood(food: Point){
        game.actualScore.score += food.value;
        // delete this.foods[this.foods.indexOf(food)];
        food.isFood = false;
        food.removeElement();
        console.log("score: "+game.actualScore.score);
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

}

class Point{
    coordinates: [number, number];
    value: number;
    isFood: boolean;
    htmlElement: HTMLElement;
    static iterator: number = 0;

    constructor(_coordinates: [number, number], _value: number, _isFood: boolean = false){
        this.coordinates = _coordinates;
        this.value = _value;
        this.isFood = _isFood;
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