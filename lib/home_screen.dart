import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void gameOver() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Image.asset('assets/images/message.png'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GameWidget(
                    game: MyGame(
                  onGameOver: gameOver,
                )),
              ));
            },
          ),
          SizedBox(
            width: 250,
            child: Column(
              children: [
                Text('Bird'),
                Text('...'),
                Text('Pipe'),
                Text('...'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
