part of model;

class Scores {
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
  String nick = "Your nick";
  DateTime date;
  int score;

  Score({this.score: 0}){
    date = new DateTime.now();

  }
}