import 'package:egyptian_ratscrew/deck/createDeck.dart';
import 'package:egyptian_ratscrew/deck/model.dart';
import 'package:egyptian_ratscrew/player/model.dart';

List<PlayerModel> initPlayers() {
  var playerNames = ["Ouest", "Nord", "Est", "Sud"];
  var deck = createDeck();
  deck.shuffle();
  List<PlayerModel> players = [];
  deck.equallySplit(playerNames.length).asMap().forEach((index, element) {
    players.add(PlayerModel(
        name: playerNames[index], deck: element, isCPU: index != 0, id: index));
  });
  return players;
}

// void winsTalon(PlayerModel player, DeckModel Talon){

// }

bool isTalonSlapable(DeckModel talon) {
  var actualCards =
      talon.cards.where((element) => !element.isUpsideDown).toList();
  if (actualCards.length < 2) return false;
  var card1 = actualCards.last;
  var card2 = actualCards[actualCards.length - 2];
  if (card1.value == card2.value) return true;
  if (card1.value + card2.value == 10) return true;
  if (actualCards.length > 2) {
    var card3 = actualCards[actualCards.length - 3];
    if (card1.value == card3.value) return true;
    if (card1.value + card3.value == 10) return true;
  }
  if (actualCards.length > 3) {
    var card4 = actualCards[actualCards.length - 3];
    if (card1.value == card4.value) return true;
    if (card1.value + card4.value == 10) return true;
  }
  return false;
}
