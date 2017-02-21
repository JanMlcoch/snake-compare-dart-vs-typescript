import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:dart/services/game_service.dart';
import 'package:dart/model/library.dart';

@Component(
  selector: 'scores',
  template: '''
    <h2>Best scores:</h2>
    <div id="scores">
      <div *ngFor="let score of scores">
        <span class="name">{{score.nick}}</span>
        <span class="score">{{score.score}}</span>
      </div>
    </div>
  ''',
  directives: const [
    materialDirectives
  ],
  providers: const [
    materialProviders
  ],
)
class ScoresComponent{
  final GameService gameService;
  List<Score> get scores => gameService.scores.sortedScores;

  ScoresComponent(this.gameService);

}
