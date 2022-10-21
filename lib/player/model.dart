import 'dart:math';

import 'package:egyptian_ratscrew/card/model.dart';
import 'package:egyptian_ratscrew/deck/model.dart';
import 'package:flutter/cupertino.dart';

class PlayerModel {
  final String name;
  final DeckModel deck;
  bool isAlive = true;
  bool isCardLess = false;
  final bool isCPU;
  final int id;
  PlayerModel(
      {required this.name,
      required this.deck,
      required this.isCPU,
      required this.id});

  CardModel plays() {
    if (deck.cards.length == 1) {
      isCardLess = true;
    }
    var card = deck.pop();
    card.isUpsideDown = false;
    debugPrint("$id joue ${card.toString()}");

    return card;
  }

  List<CardModel> discards(int nb) {
    var maxCards = min(nb, deck.cards.length);
    if (maxCards == deck.cards.length) {
      isCardLess = true;
    }
    print("$id discards $nb");
    var cards = deck.cards.sublist(0, maxCards);
    for (var card in cards) {
      card.isUpsideDown = true;
    }
    for (var i = 0; i < maxCards; i++) {
      deck.pop();
    }
    return cards;
  }
}
