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

  String selectedBirdColor = 'yellow'; // default bird color
  String selectedPipeColor = 'green'; // default pipe color

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Select Bird Color:',
            style: TextStyle(fontSize: 16), // Reduced font size
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['yellow', 'red', 'blue'].map((color) {
              return Padding(
                padding: const EdgeInsets.all(4.0), // Reduced padding
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color == 'yellow'
                        ? Colors.amber
                        : color == 'red'
                            ? Colors.red
                            : Colors.blue,
                    minimumSize: Size(60, 40), // Smaller button size
                  ),
                  onPressed: () {
                    setState(() {
                      selectedBirdColor = color;
                    });
                  },
                  child: Text(
                    color.toUpperCase(),
                    style: TextStyle(fontSize: 12), // Reduced text size
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Pipe Color:',
            style: TextStyle(fontSize: 16), // Reduced font size
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['green', 'red'].map((color) {
              return Padding(
                padding: const EdgeInsets.all(4.0), // Reduced padding
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color == 'green'
                        ? Colors.green
                        : Colors.redAccent,
                    minimumSize: Size(60, 40), // Smaller button size
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPipeColor = color;
                    });
                  },
                  child: Text(
                    color.toUpperCase(),
                    style: TextStyle(fontSize: 12), // Reduced text size
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            child: Image.asset(
              'assets/images/message.png',
              height: 100, // Optional: fixed height
              fit: BoxFit.contain,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameWidget(
                    game: MyGame(
                      onGameOver: gameOver,
                      birdColor: selectedBirdColor,
                      pipeColor: selectedPipeColor,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
