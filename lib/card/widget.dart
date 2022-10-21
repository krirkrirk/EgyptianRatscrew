import 'package:egyptian_ratscrew/card/model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;
  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(card.imgFile));
  }
}
