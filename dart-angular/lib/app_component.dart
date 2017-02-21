// Copyright (c) 2017, Crat. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:dart/components/snake_table_component.dart';
import 'package:dart/components/settings_component.dart';
import 'package:dart/components/score_component.dart';
import 'package:dart/components/scores_component.dart';
import 'package:dart/services/game_service.dart';
import 'package:dart/services/snake_service.dart';

@Component(
  selector: 'snake-game',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    SnakeTableComponent,
    SettingsComponent,
    ScoreComponent,
    ScoresComponent
  ],
  providers: const [
    materialProviders,
    GameService,
    SnakeService
  ],
)
class AppComponent {
  // Nothing here yet. All logic is in HelloDialog.
}
