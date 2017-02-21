// Copyright (c) 2017, Crat. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:dart/game/library.dart';
import 'package:dart/presentation/libs/library.dart';
import 'package:dart/presentation/libs/deferred_lib.dart';

void main() {
  Game game = new Game();
  querySelector('#startGame').onClick.listen((_){
    game.startGame();
  });

//  new TestLib();
  new DeferredLibTest();
}



