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

  String selectedColor = 'yellow'; // default bird color

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Select Bird Color:', style: TextStyle(fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['yellow', 'red', 'blue'].map((color) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color == 'yellow'
                        ? Colors.amber
                        : color == 'red'
                            ? Colors.red
                            : Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: Text(color.toUpperCase()),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            child: Image.asset('assets/images/message.png'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GameWidget(
                    game: MyGame(
                  onGameOver: gameOver,
                  birdColor: selectedColor, // pass the color here!
                )),
              ));
            },
          ),
        ],
      ),
    );
  }
}
