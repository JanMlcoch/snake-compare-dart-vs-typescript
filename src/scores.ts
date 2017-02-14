/**
 * Created by Crat on 09.02.2017.
 */

class Scores{
    scores: Score[] = [];
    sortedScores: Score[];

    addNewScore(score:Score){
        this.scores.push(score);
        this.sortScores();
    }

    sortScores(){
        this.sortedScores = this.scores;
        this.sortedScores.sort((score1: Score, score2: Score) => score2.score - score1.score);
    }
}

class Score{
    nick: string = "";
    date: number;
    score: number;

    constructor(_nick: string, _score: number){
        this.nick = _nick;
        this.score = _score;
        this.date = Date.now();
    }
}