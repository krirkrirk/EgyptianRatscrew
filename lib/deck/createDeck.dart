import 'package:egyptian_ratscrew/card/model.dart';
import 'package:egyptian_ratscrew/deck/model.dart';

final suits = ["hearts", "spades", "clubs", "diamonds"];
DeckModel createDeck() {
  List<CardModel> cards = [];
  for (final suit in suits) {
    for (var value = 1; value < 14; value++) {
      cards.add(CardModel(value: value, suit: suit));
    }
  }
  return DeckModel(cards);
}
