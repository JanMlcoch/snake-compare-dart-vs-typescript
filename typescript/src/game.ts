/**
 * Created by Crat on 08.02.2017.
 */

enum Levels {Amateur = 100, Normal = 50, Profi = 30}
enum Direction {Left, Right, Top, Down}

class Game{
    isStarted: boolean = false;
    isPaused: boolean = false;
    isAllowedWall: boolean = false;
    isAllowedSnake: boolean = false;
    difficulty: Levels = Levels.Amateur;
    table: Table = new Table(this);
    snake: Snake = new Snake(this);
    scores: Scores = new Scores();
    actualScore: Score;
    timer: number;

    startGame() {
        if(this.isStarted) return;
        this.actualScore = new Score((<HTMLInputElement> document.getElementById('nick')).value, 0);
        document.getElementById('score').innerHTML = this.actualScore.score.toString();
        this.snake.direction = Direction.Right;
        this.isPaused = false;
        this.isStarted = true;
        this.setDifficulty();
        this.initTimer();
        document.onkeydown = (event: KeyboardEvent) => {
            switch (event.keyCode){
                //Left
                case 37:
                    if(this.snake.direction == Direction.Right) {
                        return;
                    }
                    this.snake.direction = Direction.Left;
                    break;
                // Right
                case 39:
                    if(this.snake.direction == Direction.Left) {
                        return;
                    }
                    this.snake.direction = Direction.Right;
                    break;
                // Top
                case 38:
                    if(this.snake.direction == Direction.Down) {
                        return;
                    }
                    this.snake.direction = Direction.Top;
                    break;
                // Down
                case 40:
                    if(this.snake.direction == Direction.Top) {
                        return;
                    }
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

    tick() {
        if (!this.isPaused && this.isStarted) {
            this.snake.move();
        }
        this.initTimer();
    }

    updateScore(food: FoodPoint){
        this.actualScore.score += food.value;
        document.getElementById('score').innerHTML = this.actualScore.score.toString();
    }

    endGame(){
        this.isStarted = false;
        let scoresElement = document.getElementById('scores');
        this.scores.addNewScore(this.actualScore);
        scoresElement.innerHTML = '';
        for(let score of this.scores.sortedScores){
            let contEl: HTMLDivElement = document.createElement('div');
            let nameEl: HTMLSpanElement = document.createElement('span');
            let scoreEl: HTMLSpanElement = document.createElement('span');
            nameEl.classList.add('name');
            nameEl.innerHTML = score.nick;
            scoreEl.classList.add('score');
            scoreEl.innerHTML = score.score.toString();
            contEl.appendChild(nameEl);
            contEl.appendChild(scoreEl);
            scoresElement.appendChild(contEl);
        }
        this.table.resetTable();
        this.snake.resetSnake();
        // this.actualScore = new Score((<HTMLInputElement> document.getElementById('nick')).value, 0);
    }


    setDifficulty(){
        let difficultyRadios = document.getElementsByName("difficulty");
        let difficulty: string;
        for(let i = 0; i < difficultyRadios.length; i++){
            let difficultyRadio = difficultyRadios[i];
            if((<HTMLInputElement> difficultyRadio).checked){
                difficulty = difficultyRadio.id;
            }
        }
        switch (difficulty){
            case 'difficulty-easy':
                this.difficulty = Levels.Amateur;
                break;
            case 'difficulty-normal':
                this.difficulty = Levels.Normal;
                break;
            case 'difficulty-hard':
                this.difficulty = Levels.Profi;
                break;

        }
    }
}

let game = new Game();
