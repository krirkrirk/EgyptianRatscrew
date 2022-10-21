import 'package:egyptian_ratscrew/deck/model.dart';
import 'package:egyptian_ratscrew/player/model.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({Key? key, required this.player, required this.isEldest})
      : super(key: key);
  final PlayerModel player;
  final bool isEldest;
  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
        "${widget.player.name}${widget.isEldest ? "*" : ""} : ${widget.player.deck.cards.length} cards");
  }
}
