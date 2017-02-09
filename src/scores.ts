/**
 * Created by Crat on 09.02.2017.
 */

class Scores{
    scores: Score[];
    sortedScores: Score[];
}

class Score{
    nick: string = "";
    date: number;
    score: number;

    constructor(_score: number){
        this.score = _score;
        this.date = Date.now();
    }
}