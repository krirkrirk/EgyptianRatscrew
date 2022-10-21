import 'package:egyptian_ratscrew/card/model.dart';

class DeckModel {
  List<CardModel> cards;
  DeckModel(this.cards);

  void shuffle() {
    cards.shuffle();
  }

  List<DeckModel> equallySplit(int nb) {
    var dividand = cards.length ~/ nb;
    var remainder = cards.length % nb;
    return List<DeckModel>.generate(nb, (index) {
      var nbCartes = dividand + (index < remainder ? 1 : 0);
      var start = index * dividand + remainder;
      return DeckModel(cards.sublist(start, start + nbCartes));
    });
  }

  CardModel pop() {
    return cards.removeAt(0);
  }

  void addAtStart(List<CardModel> items) {
    cards.insertAll(0, items);
  }

  //play top card
  //add cards to bottom
  //spread equally in x decks
}
