/**
 * Created by Crat on 09.02.2017.
 */

class Snake{
    snakeBody: Point[] = [];
    nextPoint: Point;
    direction: Direction = Direction.Right;
    game: Game;

    constructor(game: Game){
        this.game = game;
        this.initSnake();
    }

    initSnake(){
        let middleY = Math.floor(Table.size[1] / 2);
        let a: Point = this.getSnakePoint(0,middleY);
        let b: Point = this.getSnakePoint(1,middleY);
        let c: Point = this.getSnakePoint(2,middleY);
        this.nextPoint = new Point([3,middleY]);
    }

    getSnakePoint(x: number, y: number): Point{
        let point: Point = new Point([x,y]);
        this.addPointToSnake(point);
        return point;
    }

    move(){
        if(this.resolveWallCollision()){
            if(this.game.isAllowedWall){
                this.goThroughWall();
            }else{
                this.collision();
            }
            return;
        }
        if(this.resolveSnakeCollision()){
            if(!this.game.isAllowedSnake){
                this.collision();
            }
            return;
        }
        if(this.nextPoint instanceof FoodPoint){
            this.game.table.ateFood(<FoodPoint> this.nextPoint);
        }else{
            this.removeLastBodyPoint();
        }
        this.addPointToSnake(this.nextPoint);
        this.resolveNextPoint();
    }

    addPointToSnake(point: Point){
        point.htmlElement.classList.add("snake");
        this.snakeBody.push(point);
        this.game.table.addPointIntoContainer(point);
    }

    goThroughWall(){
        let coo: [number,number];
        // Over right side
        if(this.nextPoint.coordinates[0] >= Table.size[0]){
            coo = [0, this.nextPoint.coordinates[1]];
        }
        // Over left side
        else if(this.nextPoint.coordinates[0] < 0){
            coo = [Table.size[0] - 1, this.nextPoint.coordinates[1]];
        }
        // Over bottom side
        else if(this.nextPoint.coordinates[1] >= Table.size[1]){
            coo = [this.nextPoint.coordinates[0], 0];
        }
        // Over top side
        else{
            coo = [this.nextPoint.coordinates[0], Table.size[1] - 1];
            // this.collision();
        }
        let mirrorPoint: Point = new Point(coo);
        this.addPointToSnake(mirrorPoint);
        this.removeLastBodyPoint();
        this.resolveNextPoint();
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
        if(this.game.table.getFoodOnCoo(newCoo) != null){
            this.nextPoint = this.game.table.getFoodOnCoo(newCoo);
        }else{
            this.nextPoint = new Point(newCoo);
        }
    }

    removeLastBodyPoint(){
        let last: Point = this.snakeBody[0];
        this.game.table.removePointFromContainer(last);
        this.snakeBody = this.snakeBody.slice(1);
        // delete this.body[this.body.indexOf(last)];
    }

    resolveWallCollision(): boolean{
        let horizontalCollision: boolean = this.nextPoint.coordinates[0] >= Table.size[0] || this.nextPoint.coordinates[0] < 0;
        let verticalCollision: boolean = this.nextPoint.coordinates[1] >= Table.size[1] || this.nextPoint.coordinates[1] < 0;
        return horizontalCollision || verticalCollision;
    }

    resolveSnakeCollision(): boolean{
        return this.game.table.isSnakeOnCoo(this.nextPoint.coordinates);
    }

    collision(){
        game.endGame();
    }

    resetSnake(){
        this.snakeBody = [];
        this.direction = Direction.Right;
        this.initSnake();
    }
}