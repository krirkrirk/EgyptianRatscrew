import 'dart:async';
import 'dart:math';

import 'package:egyptian_ratscrew/ai.dart';
import 'package:egyptian_ratscrew/card/widget.dart';
import 'package:egyptian_ratscrew/deck/model.dart';
import 'package:egyptian_ratscrew/game.dart';
import 'package:egyptian_ratscrew/player/widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demor Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int turn = Random().nextInt(4);
  int currentBid = 0;
  int bidder = -1;
  var players = initPlayers();
  var talon = DeckModel([]);
  bool isSlapable = false;
  List<Timer> slapTimers = [];
  Timer? playTimer, collectTimer;

  void reset() {
    setState(() {
      turn = Random().nextInt(4);
      currentBid = 0;
      bidder = -1;
      players = initPlayers();
      talon = DeckModel([]);
      isSlapable = false;
      slapTimers.forEach((element) {
        element.cancel();
      });
      playTimer?.cancel();
      collectTimer?.cancel();
    });
  }

  void resetSlapTimers() {
    slapTimers.forEach((element) {
      element.cancel();
    });
  }

  void onTurnStart() {}

  void winsTalon(int playerIndex) {
    players[playerIndex].deck.cards.addAll(talon.cards);
    talon.cards.clear();
    players.asMap().forEach((index, player) {
      if (player.isCardLess && index != playerIndex) {
        player.isAlive = false;
      }
    });
    setState(() {
      turn = playerIndex;
      currentBid = 0;
    });
    debugPrint("$playerIndex wins talon");
    bool isOver = players[playerIndex].deck.cards.length == 52;
    if (isOver) {
      debugPrint("over");
    }
    if (!isOver) {
      playTimer = Timer(const Duration(milliseconds: 1000), nextTurn);
    }
  }

  int getNextPlayerIndex() {
    for (var i = (turn + 1) % 4; i != turn; i = (i + 1) % 4) {
      if (!players[i].isCardLess) {
        return i;
      }
    }
    return -1;
  }

  void onUserSlap() {
    debugPrint("a${slapTimers.toString()}");
    playTimer?.cancel();
    collectTimer?.cancel();

    resetSlapTimers();
    setState(() {
      if (isSlapable) {
        winsTalon(0);
      } else {
        var cards = players[0].discards(2);
        talon.addAtStart(cards);
      }
    });
  }

  void onCPUSlap(int playerIndex) {
    debugPrint("$playerIndex slaps at ${DateTime.now().toString()}");
    resetSlapTimers();
    collectTimer?.cancel();
    playTimer?.cancel();

    setState(() {
      if (isSlapable) {
        winsTalon(playerIndex);
      } else {
        var cards = players[playerIndex].discards(2);
        talon.addAtStart(cards);
      }
    });
  }

  void start() {
    if (turn == 0) return;
    nextTurn();
  }

  void nextTurn([bool userTurn = false]) {
    if (turn == -1) {
      return;
    }
    var card = players[userTurn ? 0 : turn].plays();

    bool setTimer = true;
    setState(() {
      talon.cards.add(card);
      isSlapable = isTalonSlapable(talon);
      debugPrint(isSlapable.toString());
      if (slapTimers.every((element) => !element.isActive)) {
        slapTimers = getSlapsTimeout(
            isSlapable: isSlapable,
            cpus: players.where((element) => element.isCPU).toList(),
            callback: onCPUSlap);
      }

      if (card.isCourt) {
        bidder = turn;
        currentBid = card.bidValue;
        turn = getNextPlayerIndex();
      } else {
        if (currentBid > 0) {
          currentBid = max(currentBid - 1, 0);
          if (currentBid == 0 || players[turn].deck.cards.isEmpty) {
            collectTimer = Timer(
                const Duration(milliseconds: 1000), () => winsTalon(bidder));
            setTimer = false;
          }
        } else {
          turn = getNextPlayerIndex();
        }
      }
    });

    if (setTimer) {
      playTimer = Timer(const Duration(milliseconds: 1000), nextTurn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: players.length,
                itemBuilder: (BuildContext context, int index) {
                  return PlayerWidget(
                    player: players[index],
                    isEldest: turn == index,
                  );
                }),
            Text("Talon : ${talon.cards.length} cards"),
            if (talon.cards.isNotEmpty) CardWidget(card: talon.cards.last),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      start();
                    },
                    child: const Text("Start")),
                OutlinedButton(
                    onPressed: () {
                      if (turn == 0) nextTurn(true);
                    },
                    child: const Text("Jouer")),
                OutlinedButton(
                    onPressed: onUserSlap, child: const Text("slap")),
                OutlinedButton(onPressed: reset, child: const Text("Reset")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
