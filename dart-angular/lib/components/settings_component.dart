import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:dart/services/game_service.dart';
import 'package:dart/model/library.dart';

@Component(
  selector: 'settings',
  template: '''
    <h2>Difficulty</h2>
    <form id="difficulty">
      <label for="nick">Your nick: </label><input type="text" id="nick" [(ngModel)]="game.actualScore.nick"><br>
      <input type="radio" id="difficulty-easy" value="difficulty-easy" name="difficulty" (change)="setDifficulty(\$event.target.value)"><label for="difficulty-easy">Easy</label>
      <input type="radio" id="difficulty-normal" value="difficulty-normal" name="difficulty" checked (change)="setDifficulty(\$event.target.value)"><label for="difficulty-normal">Normal</label>
      <input type="radio" id="difficulty-hard" value="difficulty-hard" name="difficulty" (change)="setDifficulty(\$event.target.value)"><label for="difficulty-hard">Hard</label>
    </form>
    <a href="javascript:;" id="startGame" (click)="startGame()">Start game</a>
  ''',
  directives: const [
    materialDirectives
  ],
  providers: const [
    materialProviders
  ],
)
class SettingsComponent{
  final GameService _gameService;
  Game get game => _gameService.game;

  SettingsComponent(this._gameService);

  void startGame(){
    _gameService.startGame();
  }

  void setDifficulty(String id){
    switch (id){
      case 'difficulty-easy':
        game.difficulty = Levels.Amateur;
        break;
      case 'difficulty-normal':
        game.difficulty = Levels.Normal;
        break;
      case 'difficulty-hard':
        game.difficulty = Levels.Profi;
        break;
    }
  }

}
