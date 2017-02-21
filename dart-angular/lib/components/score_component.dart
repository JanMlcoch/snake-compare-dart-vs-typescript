import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:dart/services/game_service.dart';
import 'package:dart/model/library.dart';

@Component(
  selector: 'score',
  template: '''
    <h3>Your score: <span id="score">{{game.actualScore.score}}</span></h3>
  ''',
  directives: const [
    materialDirectives
  ],
  providers: const [
    materialProviders
  ],
)
class ScoreComponent{
  final GameService gameService;
  Game get game => gameService.game;

  ScoreComponent(this.gameService);
}
