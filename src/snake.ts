/**
 * Created by Crat on 09.02.2017.
 */

class Snake{
    snakeBody: Point[] = [];
    nextPoint: Point;
    direction: Direction = Direction.Right;

    constructor(){
        this.initSnake();
    }

    initSnake(){
        let middleY = Math.floor(Table.size[1] / 2);
        let a: Point = this.getSnakePoint(0,middleY);
        let b: Point = this.getSnakePoint(1,middleY);
        let c: Point = this.getSnakePoint(2,middleY);
        this.nextPoint = new Point([3,middleY], 1, false);
    }

    getSnakePoint(x: number, y: number): Point{
        let point: Point = new Point([x,y], 1, false);
        this.addPointToSnake(point);
        return point;
    }

    move(){
        if(this.resolveCollision()){
            this.collision();
            return;
        }
        if(this.nextPoint.isFood){
            game.table.ateFood(this.nextPoint);
        }else{
            this.removeLastBodyPoint();
        }
        this.addPointToSnake(this.nextPoint);
        this.resolveNextPoint();
    }

    addPointToSnake(point: Point){
        point.htmlElement.classList.add("snake");
        this.snakeBody.push(point);
        game.table.addPointIntoContainer(point);
    }

    resolveNextPoint(){
        let snakeHeadCoo: [number, number] = this.snakeBody[this.snakeBody.length - 1].coordinates;
        let newCoo: [number, number];
        switch (this.direction){
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
            this.nextPoint = game.table.getFoodOnCoo(newCoo);
        }else{
            this.nextPoint = new Point(newCoo, 1);
        }
    }

    removeLastBodyPoint(){
        let last: Point = this.snakeBody[0];
        game.table.removePointFromContainer(last);
        this.snakeBody = this.snakeBody.slice(1);
        // delete this.body[this.body.indexOf(last)];
    }

    resolveCollision(): boolean{
        let horizontalCollision: boolean = this.nextPoint.coordinates[0] >= Table.size[0] || this.nextPoint.coordinates[0] < 0;
        let verticalCollision: boolean = this.nextPoint.coordinates[1] >= Table.size[1] || this.nextPoint.coordinates[1] < 0;
        return horizontalCollision || verticalCollision;
    }

    collision(){
        game.isPaused = true;
        console.log("collision");
    }
}