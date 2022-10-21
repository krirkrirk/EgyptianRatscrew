import 'dart:async';
import 'dart:math';

import 'package:egyptian_ratscrew/player/model.dart';
import 'package:flutter/cupertino.dart';

List<Timer> getSlapsTimeout(
    {required bool isSlapable,
    required List<PlayerModel> cpus,
    required Function callback}) {
  if (!isSlapable) return [];

  List<Timer> timers = [];

  cpus.forEach((player) {
    var delay = 200 + Random().nextInt(500);
    debugPrint(delay.toString());
    timers
        .add(Timer(Duration(milliseconds: delay), (() => callback(player.id))));
  });
  return timers;
}
