String getSymbolForSuit(String suit) {
  switch (suit) {
    case "hearts":
      return "♥";
    case "diamonds":
      return "♦";
    case "clubs":
      return "♦";
    case "spades":
      return "♠";
  }
  return "";
}

String getNameFromIntValue(int value) {
  switch (value) {
    case 1:
      return "As";
    case 2:
      return "2";
    case 3:
      return "3";
    case 4:
      return "4";
    case 5:
      return "5";
    case 6:
      return "6";
    case 7:
      return "7";
    case 8:
      return "8";
    case 9:
      return "9";
    case 10:
      return "10";
    case 11:
      return "V";
    case 12:
      return "D";
    case 13:
      return "R";
    default:
      return "";
  }
}

int getBidValue(cardValue) {
  switch (cardValue) {
    case 1:
      return 4;
    case 11:
      return 1;
    case 12:
      return 2;
    case 13:
      return 3;
    default:
      return 0;
  }
}

class CardModel {
  int value; // 1=as to 13=roi
  String suit;
  bool isCourt;
  int bidValue;
  bool isUpsideDown = false;
  String imgFile = "";
  CardModel({required this.value, required this.suit})
      : isCourt = (value > 10 || value == 1),
        bidValue = getBidValue(value),
        imgFile = "assets/cards/$suit/$value.png";

  @override
  String toString() =>
      "${getNameFromIntValue(value)} ${getSymbolForSuit(suit)}";
}
