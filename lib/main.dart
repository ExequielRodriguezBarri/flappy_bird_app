import 'package:flutter/material.dart';

import 'home_screen.dart';


//I think this hw will take me about 3 hs to complete
//It took me 5:40 hs to complete it

//1. The game could have a pause feature that allows the player to pause the game and resume later.
//2. The game could have a leaderboard feature that shows the top 10 scores of the player.
//3. The game could have a sound feature that allows the player to toggle the sound on and off.
//4. The game could have a settings feature that allows the player to change the game settings such as difficulty level, sound volume, etc.
//5. The game could have a tutorial feature that shows the player how to play the game.
//6. The game could have a feedback feature that allows the player to send feedback or report bugs.


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}
