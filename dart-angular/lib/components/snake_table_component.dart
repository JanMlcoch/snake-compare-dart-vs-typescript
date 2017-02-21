import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:dart/services/snake_service.dart';
import 'package:dart/services/game_service.dart';
import 'package:dart/model/library.dart';

@Component(
  selector: 'snake-table',
  styleUrls: const ['snake_table_component.css'],
  templateUrl: 'snake_table_component.html',
  directives: const [
    materialDirectives
  ],
  providers: const [
    materialProviders
  ],
)
class SnakeTableComponent{
  final GameService gameService;
  final SnakeService snakeService;
  Snake get snake => snakeService.snake;
  Game get game => gameService.game;
  Table get table => gameService.table;

  SnakeTableComponent(this.gameService, this.snakeService){

  }

}