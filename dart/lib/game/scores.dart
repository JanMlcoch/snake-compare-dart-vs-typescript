part of game;

class Scores{
  List<Score> scores = [];
  List<Score> sortedScores = [];

  void addNewScore(Score actualScore) {
    scores.add(actualScore);
    sortScores();
  }

  void sortScores() {
    sortedScores = scores;
    sortedScores.sort((Score score1, Score score2) => score2.score - score1.score);
  }
}

class Score{
  String nick;
  DateTime date;
  int score;

  Score(this.nick, this.score){
    date = new DateTime.now();
  }
}